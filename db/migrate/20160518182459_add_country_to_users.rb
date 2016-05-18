class AddCountryToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :country, :string
  end
end
