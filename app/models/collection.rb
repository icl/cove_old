class Collection < ActiveRecord::Base
  has_and_belongs_to_many :intervals
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :projects
  
  def update_priority(priority)
    
  end
  
end
