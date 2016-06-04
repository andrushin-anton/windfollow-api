class CreateApiV1ReportImages < ActiveRecord::Migration
  def change
    create_table :api_v1_report_images do |t|
      t.integer :report_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
