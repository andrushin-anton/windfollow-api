class AddSpotIdToAlerts < ActiveRecord::Migration
  def change
    add_column :api_v1_alerts, :spot_id, :integer
  end
end
