class CreateApiV1ReportComments < ActiveRecord::Migration
  def change
    create_table :api_v1_report_comments do |t|
      t.integer :report_id
      t.integer :user_id
      t.string :content

      t.timestamps null: false
    end
  end
end
