class AddCityToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :city, :string
  end
end
