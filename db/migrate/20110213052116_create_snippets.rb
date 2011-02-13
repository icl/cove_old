class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.references :interval
      t.string :title
      t.string :description
      t.decimal :offset
      t.decimal :duration

      t.timestamps
    end
  end

  def self.down
    drop_table :snippets
  end
end
