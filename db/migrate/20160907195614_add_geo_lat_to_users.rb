class AddGeoLatToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :geo_lat, :string
    add_column :api_v1_users, :geo_lon, :string
  end
end
