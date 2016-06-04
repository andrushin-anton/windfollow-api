class CreateApiV1ReportImageLikes < ActiveRecord::Migration
  def change
    create_table :api_v1_report_image_likes do |t|
      t.integer :user_id
      t.integer :report_image_id

      t.timestamps null: false
    end
  end
end
