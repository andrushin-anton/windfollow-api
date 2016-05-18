class AddSportIdToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :sport_id, :integer
  end
end
