class AddSensorEnabledToAlerts < ActiveRecord::Migration
  def change
    add_column :api_v1_alerts, :sensor_enabled, :integer
  end
end
