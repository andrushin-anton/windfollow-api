class AddIndexToUserActivity < ActiveRecord::Migration
  def change
    add_index :api_v1_user_activities, :user_id
    add_index :api_v1_user_activities, :updated_at
  end
end
