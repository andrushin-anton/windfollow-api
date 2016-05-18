class AddImageToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :image, :string
  end
end
