class AddAvatarToUsers < ActiveRecord::Migration
  def self.up
    add_attachment :api_v1_users, :avatar
  end

  def self.down
    remove_attachment :api_v1_users, :avatar
  end
end
