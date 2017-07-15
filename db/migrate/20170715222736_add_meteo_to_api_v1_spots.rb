class AddMeteoToApiV1Spots < ActiveRecord::Migration
  def change
    add_column :api_v1_spots, :meteo, :integer
  end
end
