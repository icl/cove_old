class Project < ActiveRecord::Base
   #def tags=(tags)
   #   tags.reject(&:blank?)
   #end
   belongs_to :user
   serialize :tags
   has_and_belongs_to_many :collections
   has_and_belongs_to_many :notes
end
