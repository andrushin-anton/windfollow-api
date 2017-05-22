class DropMessages < ActiveRecord::Migration
  def up
    drop_table :api_v1_messages
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
