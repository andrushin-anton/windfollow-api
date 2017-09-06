class AddGeoLatToReports < ActiveRecord::Migration
  def change
    add_column :api_v1_reports, :geo_lat, :string
    add_column :api_v1_reports, :geo_lon, :string
  end
end
