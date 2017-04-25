class AddKeyToReportViewsCount < ActiveRecord::Migration
  def change
    add_index :api_v1_report_views_counts, :report_id
  end
end
