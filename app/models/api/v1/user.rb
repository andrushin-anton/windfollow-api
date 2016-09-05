require 'digest/md5'
require "base64"

class Api::V1::User < ActiveRecord::Base
	validates :email, presence: true, length: { maximum: 70 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :password, presence: true, length: { in: 6..70 }
	validates :email, :uniqueness => true, on: [:save]
	validates :first_name, presence: true, length: { maximum: 30 }, on: [:save]
	validates :last_name, presence: true, length: { maximum: 30 }, on: [:save]
  validates :gender, :inclusion => { :in => ['m', 'f'] }, :allow_blank => true
  validates :wind, :inclusion => { :in => ['m/s', 'mph', 'km/h', 'bft', 'knots'] }, :allow_blank => true
  validates :temp, :inclusion => { :in => ['c', 'f'] }, :allow_blank => true

  # This method associates the attribute ":image" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	before_save :default_values, :encrypt_password

  has_many :sport_users
  has_many :sports, through: :sport_users
  has_many :followers, :foreign_key => 'user_id'
  has_many :followings, :foreign_key => 'follower_id'
  has_many :spots

  attr_accessor :place

  KEY = Rails.application.config.secret_key_base

	#scope :authorize, -> (email, password) { where('email =? and password =?', email, Digest::MD5.hexdigest(password)) }

  def formated_avatar
    self.avatar.url.sub! 's3.amazonaws.com/windfollow', 'windfollow.s3.amazonaws.com'
  end
  
  def authorize(email, password)
  	Api::V1::User.where('email =? and password =?', email, Digest::MD5.hexdigest(password)).first
  end

  def generate_token
  	payload = {:user_id => self.id, :exripires_at => 1.month.from_now }
  	# encrypt the payload
  	encrypted_data = Base64.urlsafe_encode64(AESCrypt.encrypt(payload.to_json, KEY))
  	# return json object containing token
  	{:access_token => encrypted_data, :exripires_at => 1.month.from_now}.to_json
  end

  def self.validate_token(token)
  	payload_json = AESCrypt.decrypt(Base64.urlsafe_decode64(token), KEY)
  	payload = JSON.parse(payload_json)
  	if payload.has_key?('user_id') && payload.has_key?('exripires_at')
  		unless payload['exripires_at'].to_datetime.past?
  			return Api::V1::User.find(payload['user_id'])
  		end
  	end
  	return false
  end

  def default_values
    self.rating ||= 0
    self.wind ||= 'm/s'
    self.temp ||= 'c'

    # places
    unless self.place.nil?
      places = self.place.split(',')
      # parse place
      self.country = places.last
      self.city = self.place.chomp(',' + self.country)
    end
  end

  def gender_defined?
    self.gender.nil?
  end

  def encrypt_password
  	self.password = Digest::MD5.hexdigest(self.password)
  end

  def password_refresh
    new_password = rand(0..9).to_s+''+rand(0..9).to_s+''+rand(0..9).to_s+''+rand(0..9).to_s+''+rand(0..9).to_s+''+rand(0..9).to_s+''
    self.password = new_password
    encrypt_password
    return new_password
  end
end
