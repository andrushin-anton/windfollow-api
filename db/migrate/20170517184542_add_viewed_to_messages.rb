class AddViewedToMessages < ActiveRecord::Migration
  def change
    add_column :api_v1_messages, :viewed, :integer, default: 0
  end
end
