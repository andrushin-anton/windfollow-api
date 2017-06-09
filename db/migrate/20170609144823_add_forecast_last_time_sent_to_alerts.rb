class AddForecastLastTimeSentToAlerts < ActiveRecord::Migration
  def change
    add_column :api_v1_alerts, :forecast_last_time_sent, :datetime
  end
end
