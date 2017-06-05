require 'digest/md5'
require "base64"

class Api::V1::User < ActiveRecord::Base
	validates :email, presence: true, uniqueness: true, length: { maximum: 70 }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :password, presence: true, length: { in: 6..70 }
	validates :email, :uniqueness => true, on: [:save]
	validates :first_name, presence: true, length: { maximum: 30 }, on: [:save]
	validates :last_name, presence: true, length: { maximum: 30 }, on: [:save]
  validates :gender, :inclusion => { :in => ['m', 'f'] }, :allow_blank => true
  validates :wind, :inclusion => { :in => ['m/s', 'mph', 'km/h', 'bft', 'knots'] }, :allow_blank => true
  validates :temp, :inclusion => { :in => ['c', 'f'] }, :allow_blank => true
  validates :timezone, :inclusion => { :in => [
    'UTC -11:00','UTC -10:00','UTC -09:00','UTC -08:00','UTC -07:00', 
    'UTC -06:00','UTC -05:00','UTC -04:30','UTC -04:00','UTC -03:30','UTC -03:00','UTC -02:00','UTC -01:00', 
    'UTC +00:00','UTC +01:00','UTC +02:00','UTC +03:00','UTC +03:30','UTC +03:00','UTC +04:00','UTC +04:30',
    'UTC +05:00','UTC +05:30','UTC +05:45','UTC +06:00','UTC +06:30','UTC +07:00','UTC +08:00','UTC +09:00',
    'UTC +09:30','UTC +10:00','UTC +11:00','UTC +12:00','UTC +12:45','UTC +13:00'
    ] }, :allow_blank => true

  # This method associates the attribute ":image" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	before_save :default_values
  before_create :encrypt_password

  has_many :sport_users
  has_many :sports, through: :sport_users
  has_many :followers, :foreign_key => 'user_id'
  has_many :followings, :foreign_key => 'follower_id'
  has_many :spots
  has_many :devices
  has_many :alerts


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
  	payload = {:user_id => self.id, :exripires_at => 1.year.from_now }
  	# encrypt the payload
  	encrypted_data = Base64.urlsafe_encode64(AESCrypt.encrypt(payload.to_json, KEY))
  	# return json object containing token
  	{:access_token => encrypted_data, :user_id => self.id, :exripires_at => 1.year.from_now}.to_json
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
    self.timezone ||= 'UTC +00:00'

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

  # Hashing passwords with md5 which is a bad idea, but we have to, because there are plenty old accounts that have their passwords hashed
  def encrypt_password
  	self.password = Digest::MD5.hexdigest(self.password)
  end

  def password_refresh
    new_password = rand(0..9).to_s+''+rand(0..9).to_s+''+rand(0..9).to_s+''+rand(0..9).to_s+''+rand(0..9).to_s+''+rand(0..9).to_s+''
    self.password = new_password
    return new_password
  end

  def get_timezone_name(timezone)
    all_timezones = {
      'UTC -11:00' => 'International Date Line West',
      'UTC -10:00' => 'Hawaii',
      'UTC -09:00' => 'Alaska',
      'UTC -08:00' => 'Pacific Time (US & Canada)',
      'UTC -07:00' => 'Mountain Time (US & Canada)',
      'UTC -06:00' => 'Central Time (US & Canada)',
      'UTC -05:00' => 'Eastern Time (US & Canada)',
      'UTC -04:30' => 'Caracas',
      'UTC -04:00' => 'Atlantic Time (Canada)',
      'UTC -03:30' => 'Newfoundland',
      'UTC -03:00' => 'Brasilia',
      'UTC -02:00' => 'Mid-Atlantic',
      'UTC -01:00' => 'Azores',
      'UTC +00:00' => 'London',
      'UTC +01:00' => 'Amsterdam',
      'UTC +02:00' => 'Athens',
      'UTC +03:00' => 'Moscow',
      'UTC +03:30' => 'Tehran',
      'UTC +04:00' => 'Yerevan',
      'UTC +04:30' => 'Kabul',
      'UTC +05:00' => 'Tashkent',
      'UTC +05:30' => 'Chennai',
      'UTC +05:45' => 'Kathmandu',
      'UTC +06:00' => 'Almaty',
      'UTC +06:30' => 'Rangoon',
      'UTC +07:00' => 'Bangkok',
      'UTC +08:00' => 'Beijing',
      'UTC +09:00' => 'Osaka',
      'UTC +09:30' => 'Adelaide',
      'UTC +10:00' => 'Brisbane',
      'UTC +11:00' => 'New Caledonia',
      'UTC +12:00' => 'Auckland',
      'UTC +12:45' => 'Chatham Is.',
      'UTC +13:00' => 'Samoa'
    }

    return all_timezones[timezone]
  end

  def get_timezone_value(timezone)
    all_timezones = {
      'UTC -11:00' => -11,
      'UTC -10:00' => -10,
      'UTC -09:00' => -9,
      'UTC -08:00' => -8,
      'UTC -07:00' => -7,
      'UTC -06:00' => -6,
      'UTC -05:00' => -5,
      'UTC -04:30' => -4,
      'UTC -04:00' => -4,
      'UTC -03:30' => -3,
      'UTC -03:00' => -3,
      'UTC -02:00' => -2,
      'UTC -01:00' => -1,
      'UTC +00:00' => 0,
      'UTC +01:00' => 1,
      'UTC +02:00' => 2,
      'UTC +03:00' => 3,
      'UTC +03:30' => 3,
      'UTC +04:00' => 4,
      'UTC +04:30' => 4,
      'UTC +05:00' => 5,
      'UTC +05:30' => 5,
      'UTC +05:45' => 5,
      'UTC +06:00' => 6,
      'UTC +06:30' => 6,
      'UTC +07:00' => 7,
      'UTC +08:00' => 8,
      'UTC +09:00' => 9,
      'UTC +09:30' => 9,
      'UTC +10:00' => 10,
      'UTC +11:00' => 11,
      'UTC +12:00' => 12,
      'UTC +12:45' => 12,
      'UTC +13:00' => 13
    }

    return all_timezones[timezone]
  end
end
