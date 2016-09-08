class CreateApiV1FavoriteSpots < ActiveRecord::Migration
  def change
    create_table :api_v1_favorite_spots do |t|
      t.integer :user_id
      t.integer :spot_id

      t.timestamps null: false
    end
  end
end
