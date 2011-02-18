class Tag < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :taggings, :dependent => :delete_all
  
  def self.can_be_created?
    true
  end
  
end
