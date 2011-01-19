class CreateIntervals < ActiveRecord::Migration
  def self.up
    create_table :intervals do |t|
      t.string :filename
      t.string :camera_angle
      t.integer :session_number
      t.datetime :start_time
      t.datetime :end_time
      t.string :session_type
      t.string :phrase_name
      t.string :phrase_type
      t.string :task_name
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :intervals
  end
end
