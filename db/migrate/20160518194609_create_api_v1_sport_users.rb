class CreateApiV1SportUsers < ActiveRecord::Migration
  def change
    create_table :api_v1_sport_users do |t|
      t.integer :sport_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
