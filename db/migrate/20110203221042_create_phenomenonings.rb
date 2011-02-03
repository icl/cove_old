class CreatePhenomenonings < ActiveRecord::Migration
  def self.up
    create_table :phenomenonings do |t|
      t.references :user
      t.references :interval
      t.references :phenomenon
      t.timestamps
    end
  end

  def self.down
    drop_table :phenomenonings
  end
end
