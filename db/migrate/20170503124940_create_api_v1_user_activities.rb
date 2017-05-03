class CreateApiV1UserActivities < ActiveRecord::Migration
  def change
    create_table :api_v1_user_activities do |t|
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
