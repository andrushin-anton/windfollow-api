class AddSensorLastTimeSentToAlerts < ActiveRecord::Migration
  def change
    add_column :api_v1_alerts, :sensor_last_time_sent, :datetime
  end
end
