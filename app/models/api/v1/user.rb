require 'digest/md5'
require "base64"

class Api::V1::User < ActiveRecord::Base
	validates :email, presence: true, length: { maximum: 70 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :password, presence: true, length: { in: 6..70 }
	validates :email, :uniqueness => true, on: [:save]
	validates :first_name, presence: true, length: { maximum: 30 }, on: [:save]
	validates :last_name, presence: true, length: { maximum: 30 }, on: [:save]
  validates :gender, :inclusion => { :in => ['m', 'f'] }, :allow_blank => true

	before_save :default_values, :encrypt_password

  has_many :sport_users
  has_many :sports, through: :sport_users

  attr_accessor :place

  KEY = '1d272f038724b99d7a5e1f4839356543ce1d3c2f'

	#scope :authorize, -> (email, password) { where('email =? and password =?', email, Digest::MD5.hexdigest(password)) }
  
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
