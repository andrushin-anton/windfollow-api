class CreateApiV1SpotEstimates < ActiveRecord::Migration
  def change
    create_table :api_v1_spot_estimates do |t|
      t.integer :spot_id
      t.integer :user_id
      t.integer :rating
      t.string :best_month
      t.string :wave
      t.string :level
      t.string :sport

      t.timestamps null: false
    end
  end
end
