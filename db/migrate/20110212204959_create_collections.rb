class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.string :name
      t.text   :description
      t.text   :interval_priorities
      t.integer :user_id
      t.timestamps
    end
    create_table :collections_intervals,:id => false do |t|
      t.references :interval
      t.references :collection
    end
    create_table :collections_projects,:id => false do |t|
      t.references :collection
      t.references :project
    end
  end

  def self.down
    drop_table :collections
    drop_table :collections_intervals
  end
end