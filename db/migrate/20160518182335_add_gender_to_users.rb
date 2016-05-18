class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :gender, :string
  end
end
