class Project < ActiveRecord::Base
   #def tags=(tags)
   #   tags.reject(&:blank?)
   #end
   belongs_to :user
   serialize :tags
end
