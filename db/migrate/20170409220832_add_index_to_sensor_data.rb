class AddIndexToSensorData < ActiveRecord::Migration
  def change
    add_index :api_v1_sensor_data, :sensor_id
  end
end
