class Note < ActiveRecord::Base
  has_and_belongs_to_many :collections
  has_and_belongs_to_many :projects
  
  validates_presence_of :note
end
