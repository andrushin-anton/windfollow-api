class CreateApiV1ReportLikes < ActiveRecord::Migration
  def change
    create_table :api_v1_report_likes do |t|
      t.integer :user_id
      t.integer :report_id

      t.timestamps null: false
    end
  end
end
