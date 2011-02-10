class ChangeIntervalEndTimeToDuration < ActiveRecord::Migration
  def self.up
    remove_column :intervals, :end_time
    add_column  :intervals, :duration, :integer, :default => 0, :null => false
  end

  def self.down
    add_column :intervals, :end_time, :datetime
    remove_column :intervals, :duration
  end
end
