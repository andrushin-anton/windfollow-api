class Api::V1::Spot < ActiveRecord::Base
  validates :name, presence: true, length: { in: 2..70 }
  validates :geo_lat, presence: true, numericality: { greater_than_or_equal_to: -90,  less_than_or_equal_to: 90 }
  validates :geo_lon, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :best_month, presence: true
  validates :wave, presence: true
  validates :level, presence: true
  validates :user_id, presence: true
  validates :sport, presence: true

  attr_accessor :place

  belongs_to :user

  before_save :default_values

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
end
