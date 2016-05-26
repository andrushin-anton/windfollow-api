class CreateApiV1Spots < ActiveRecord::Migration
  def change
    create_table :api_v1_spots do |t|
      t.string :name
      t.string :geo_lat
      t.string :geo_lon
      t.integer :rating
      t.string :best_month
      t.string :wave
      t.string :level
      t.integer :user_id
      t.string :country
      t.string :city
      t.string :sport

      t.timestamps null: false
    end
  end
end
