class Collection < ActiveRecord::Base
  has_and_belongs_to_many :intervals
  has_many :collection_tags, :dependent => :destroy
  has_many :tags, :through => :collection_tags
  
  
end
