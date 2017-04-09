class Api::V1::Sensor < ActiveRecord::Base
    validates :slug, uniqueness: true, on: [:save]
    validates :name, presence: true

    has_many :sensor_data
end
