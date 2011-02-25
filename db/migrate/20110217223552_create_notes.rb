class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text  :note
      t.timestamps
    end
    create_table :collections_notes,:id => false do |t|
      t.references :collection
      t.references :note
    end
    create_table :notes_projects,:id => false do |t|
      t.references :project
      t.references :note
    end
  end

  def self.down
    drop_table :notes
    drop_table :collections_notes
    drop_table :projects_notes
  end
end
