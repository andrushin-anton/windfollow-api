class CreateApiV1Devices < ActiveRecord::Migration
  def change
    create_table :api_v1_devices do |t|
      t.string :name
      t.string :token
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
