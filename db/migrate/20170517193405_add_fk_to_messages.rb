class AddFkToMessages < ActiveRecord::Migration
  def change
    remove_column :api_v1_messages, :recepient_id, :integer
    remove_column :api_v1_messages, :sender_id, :integer

    add_reference :api_v1_messages, :recepient, references: :api_v1_users, index: true
    add_foreign_key :api_v1_messages, :api_v1_users, column: :recepient_id

    add_reference :api_v1_messages, :sender, references: :api_v1_users, index: true
    add_foreign_key :api_v1_messages, :api_v1_users, column: :recepient_id
  end
end
