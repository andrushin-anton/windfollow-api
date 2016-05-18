class RemoveSportIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :api_v1_users, :sport_id, :integer
  end
end
