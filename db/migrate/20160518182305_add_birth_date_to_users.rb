class AddBirthDateToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :birth_date, :date
  end
end
