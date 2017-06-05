class AddDirectionToAlerts < ActiveRecord::Migration
  def change
    add_column :api_v1_alerts, :direction, :string, array: true, default: []
  end
end
