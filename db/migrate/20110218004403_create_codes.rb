class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.string :name
      t.string :coding_type
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :codes
  end
end
