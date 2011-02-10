class AddAlternalPhraseNameToIntervals < ActiveRecord::Migration
  def self.up
    add_column :intervals, :alternative_phrase_name, :string, :default => nil, :null => true
  end

  def self.down
    remove_column :intervals, :alternative_phrase_name
  end
end
