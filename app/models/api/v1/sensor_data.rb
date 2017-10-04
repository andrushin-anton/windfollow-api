class Api::V1::SensorData < ActiveRecord::Base
    belongs_to :sensor

    def clean_up
        Api::V1::SensorData.where('created_at <= ?', (Time.current - 1.day).to_s(:db)).delete_all
    end
end
