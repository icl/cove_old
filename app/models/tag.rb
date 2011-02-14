class Tag < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :tagings
  #has_and_belongs_to_many :collections
  
  def self.can_be_created?
    true
  end
  
end
