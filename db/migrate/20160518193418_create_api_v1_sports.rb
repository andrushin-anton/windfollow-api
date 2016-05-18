class CreateApiV1Sports < ActiveRecord::Migration
  def change
    create_table :api_v1_sports do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
