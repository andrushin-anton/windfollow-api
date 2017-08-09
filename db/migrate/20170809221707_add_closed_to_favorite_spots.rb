class AddClosedToFavoriteSpots < ActiveRecord::Migration
  def change
    add_column :api_v1_favorite_spots, :closed, :integer, :default => 0
  end
end
