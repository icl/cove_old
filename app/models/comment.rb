class Comment < ActiveRecord::Base
  has_many :commentings, :dependent => :delete_all
  
  def self.can_be_created?
    true
  end
  
end
