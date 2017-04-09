class CreateApiV1SensorData < ActiveRecord::Migration
  def change
    create_table :api_v1_sensor_data do |t|
      t.integer :sensor_id
      t.string :wind
      t.string :mid
      t.string :lwind
      t.string :dir
      t.string :temp1
      t.string :temp2
      t.string :h
      t.string :p
      t.string :dew_point
      t.string :alarm
      t.string :u_out

      t.timestamps null: false
    end
  end
end
