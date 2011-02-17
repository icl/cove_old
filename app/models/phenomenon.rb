class Phenomenon < ActiveRecord::Base
  has_many :phenomenonings, :dependent => :delete_all
  
  def self.can_be_created?
    false
  end
  
end
