class AddWindToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :wind, :string
  end
end
