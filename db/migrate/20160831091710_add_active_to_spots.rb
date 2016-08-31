class AddActiveToSpots < ActiveRecord::Migration
  def change
    add_column :api_v1_spots, :active, :integer
  end
end
