class Tag < ActiveRecord::Base
  has_many :interval_tags
  has_many :intervals, :through => :interval_tags 
  validates_uniqueness_of :name
end
