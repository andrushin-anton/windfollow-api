class CreateApiV1Supports < ActiveRecord::Migration
  def change
    create_table :api_v1_supports do |t|
      t.text :message
      t.text :details

      t.timestamps null: false
    end
  end
end
