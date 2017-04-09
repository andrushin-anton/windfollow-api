class AddIndexToAlerts < ActiveRecord::Migration
  def change
    add_index :api_v1_alerts, :user_id
  end
end
