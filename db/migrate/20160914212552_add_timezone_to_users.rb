class AddTimezoneToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :timezone, :string
  end
end
