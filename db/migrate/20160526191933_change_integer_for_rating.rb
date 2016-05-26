class ChangeIntegerForRating < ActiveRecord::Migration
  def up
    change_column :api_v1_spots, :rating, :string
  end

  def down
    change_column :api_v1_spots, :rating, :integer
  end
end
