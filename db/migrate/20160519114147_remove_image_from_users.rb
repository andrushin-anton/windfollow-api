class RemoveImageFromUsers < ActiveRecord::Migration
  def change
    remove_column :api_v1_users, :image, :string
  end
end
