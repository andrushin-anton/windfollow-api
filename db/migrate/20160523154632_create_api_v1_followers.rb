class CreateApiV1Followers < ActiveRecord::Migration
  def change
    create_table :api_v1_followers do |t|
      t.integer :follower_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
