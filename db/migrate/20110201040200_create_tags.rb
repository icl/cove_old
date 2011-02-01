class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.integer :user_id
      t.integer :interval_id
      t.integer :tag_type_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
