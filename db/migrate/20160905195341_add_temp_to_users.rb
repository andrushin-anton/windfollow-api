class AddTempToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :temp, :string
  end
end
