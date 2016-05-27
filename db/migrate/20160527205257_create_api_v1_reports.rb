class CreateApiV1Reports < ActiveRecord::Migration
  def change
    create_table :api_v1_reports do |t|
      t.integer :spot_id
      t.string :content
      t.integer :user_id
      t.string :place
      t.string :wind
      t.string :direction

      t.timestamps null: false
    end
  end
end
