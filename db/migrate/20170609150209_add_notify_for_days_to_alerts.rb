class AddNotifyForDaysToAlerts < ActiveRecord::Migration
  def change
    add_column :api_v1_alerts, :notify_for_days, :integer
  end
end
