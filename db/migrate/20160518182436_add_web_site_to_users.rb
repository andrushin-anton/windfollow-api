class AddWebSiteToUsers < ActiveRecord::Migration
  def change
    add_column :api_v1_users, :web_site, :string
  end
end
