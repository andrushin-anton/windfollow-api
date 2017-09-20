class CreateApiV1Pages < ActiveRecord::Migration
  def change
    create_table :api_v1_pages do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
