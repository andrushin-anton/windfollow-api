class CreateApiV1ReportViewsCounts < ActiveRecord::Migration
  def change
    create_table :api_v1_report_views_counts do |t|
      t.integer :report_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
