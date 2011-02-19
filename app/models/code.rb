class Code < ActiveRecord::Base
  has_many :codings

  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name
  validates_presence_of :coding_type

  #Sunspot Solr Stuff
  searchable do
    #primary terms
    text :name, :default_boost => 2
    text :description, :default_boost => 2
    #side terms
    text :coding_type
  end
end
