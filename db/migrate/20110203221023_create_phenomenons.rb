class CreatePhenomenons < ActiveRecord::Migration
  def self.up
    create_table :phenomenons do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :phenomenons
  end
end
