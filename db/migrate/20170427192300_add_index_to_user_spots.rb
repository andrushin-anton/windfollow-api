class AddIndexToUserSpots < ActiveRecord::Migration
  def change
    add_index :api_v1_user_spots, :user_id
  end
end
