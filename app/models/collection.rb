class Collection < ActiveRecord::Base
  has_and_belongs_to_many :intervals
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :notes
  
end
