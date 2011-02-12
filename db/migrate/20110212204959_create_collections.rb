class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|

      t.timestamps
    end
    create_table :collections_intervals,:id => false do |t|
      t.references :interval
      t.references :collection
    end
  end

  def self.down
    drop_table :collections
    drop_table :collections_intervals
  end
end