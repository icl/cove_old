class Tag < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :taggings, :dependent => :delete_all
  
  scope :unapplied, lambda {|interval_id| joins(:taggings).where("taggings.interval_id <> ?", interval_id)}

  def searchable
    #Sunspot Solr stuff
    text :name
  end
   
end
