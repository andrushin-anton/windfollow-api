class CreateMessages < ActiveRecord::Migration
  def change
    create_table :api_v1_messages do |t|
      t.text :body
      t.references :conversation, index: true
      t.references :user, index: true
      t.boolean :read, :default => false
      t.timestamps
    end
  end
end
