class CreateApiV1Alerts < ActiveRecord::Migration
  def change
    create_table :api_v1_alerts do |t|
      t.integer :user_id
      t.float :distance
      t.string :time_alert

      t.timestamps null: false
    end
  end
end
