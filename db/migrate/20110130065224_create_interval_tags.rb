class CreateIntervalTags < ActiveRecord::Migration
  def self.up
    create_table :interval_tags do |t|
      t.references :tag
      t.references :interval

      t.timestamps
    end
  end

  def self.down
    drop_table :interval_tags
  end
end
