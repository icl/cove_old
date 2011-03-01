class CreateCodings < ActiveRecord::Migration
  def self.up
    create_table :codings do |t|
      t.references :user
      t.references :interval
      t.references :code
      t.timestamps
    end
  end

  def self.down
    drop_table :codings
  end
end
