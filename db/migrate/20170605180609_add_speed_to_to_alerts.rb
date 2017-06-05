class AddSpeedToToAlerts < ActiveRecord::Migration
  def change
    add_column :api_v1_alerts, :speed_to, :integer
  end
end
