class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :api_v1_notifications, :content, :text
  end
end
