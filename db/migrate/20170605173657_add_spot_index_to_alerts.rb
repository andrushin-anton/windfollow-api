class AddSpotIndexToAlerts < ActiveRecord::Migration
  def change
    add_index :api_v1_alerts, :spot_id
  end
end
