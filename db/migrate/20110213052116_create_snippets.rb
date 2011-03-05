class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.references :interval
      t.string :title
      t.string :description
      t.decimal :offset, :scale => 2
      t.decimal :duration, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :snippets
  end
end
