class CreateApiV1Messages < ActiveRecord::Migration
  def change
    create_table :api_v1_messages do |t|
      t.integer :sender_id
      t.integer :recepient_id
      t.string :content

      t.timestamps null: false
    end
  end
end
