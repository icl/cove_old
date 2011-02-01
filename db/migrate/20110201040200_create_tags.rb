class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
