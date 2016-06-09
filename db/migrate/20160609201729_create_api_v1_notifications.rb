class CreateApiV1Notifications < ActiveRecord::Migration
  def change
    create_table :api_v1_notifications do |t|
      t.integer :user_id
      t.string :event_type
      t.string :content
      t.integer :event_object_id

      t.timestamps null: false
    end
  end
end
