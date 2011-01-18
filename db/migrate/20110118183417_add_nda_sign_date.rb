class AddNdaSignDate < ActiveRecord::Migration
  def self.up
    add_column :users, :nda_signature_date, :datetime
  end

  def self.down
    remove_column :users, :nda_signature_date
  end
end