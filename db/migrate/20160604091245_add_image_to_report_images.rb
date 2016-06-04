class AddImageToReportImages < ActiveRecord::Migration
  def self.up
    add_attachment :api_v1_report_images, :image
  end

  def self.down
    remove_attachment :api_v1_report_images, :image
  end
end
