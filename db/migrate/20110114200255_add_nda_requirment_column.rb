class AddNdaRequirmentColumn < ActiveRecord::Migration
  def self.up
    add_column :users, :nda_signed, :boolean
  end

  def self.down
    remove_column :users, :nda_signed
  end
end