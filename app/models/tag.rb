class Tag < ActiveRecord::Base
  has_many :tagings
  
  def self.can_be_created?
    true
  end
  
end
