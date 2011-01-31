class Project < ActiveRecord::Base
   #def tags=(tags)
   #   tags.reject(&:blank?)
   #end
   serialize :tags
end
