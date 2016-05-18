class AddAboutToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :about, :string
  end
end
