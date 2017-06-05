class AddSpeedFromToAlerts < ActiveRecord::Migration
  def change
    add_column :api_v1_alerts, :speed_from, :integer
  end
end
