class RemovingNotesFromProject < ActiveRecord::Migration
  def self.up
    remove_column :projects, :notes
    remove_column :projects, :tags
  end

  def self.down
    add_column :projects, :notes, :text
    add_column :projects, :tags, :text
  end
end
