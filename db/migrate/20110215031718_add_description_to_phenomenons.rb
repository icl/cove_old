class AddDescriptionToPhenomenons < ActiveRecord::Migration
  def self.up
    add_column :phenomenons, :description, :text
  end

  def self.down
    remove_column :phenomenons, :description
  end
end
