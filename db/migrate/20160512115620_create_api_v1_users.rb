class CreateApiV1Users < ActiveRecord::Migration
  def change
    create_table :api_v1_users do |t|
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.integer :rating

      t.timestamps null: false
    end
  end
end
