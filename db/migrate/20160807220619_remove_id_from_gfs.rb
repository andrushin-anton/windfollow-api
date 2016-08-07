class RemoveIdFromGfs < ActiveRecord::Migration
  def change
    remove_column :api_v1_gfs, :id, :integer
  end
end
