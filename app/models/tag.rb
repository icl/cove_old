class Tag < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :tagings
  
  def self.can_be_created?
    true
  end
  
end
