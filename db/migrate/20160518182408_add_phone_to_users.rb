class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :phone, :string
  end
end
