class CreateApiV1Sensors < ActiveRecord::Migration
  def change
    create_table :api_v1_sensors do |t|
      t.string :name
      t.string :slug
      t.string :geo_lat
      t.string :geo_lon

      t.timestamps null: false
    end
  end
end
