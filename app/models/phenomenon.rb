class Phenomenon < ActiveRecord::Base
  has_many :phenomenonings
  
  def self.can_be_created?
    false
  end
  
end
