class Interval < ActiveRecord::Base
  has_many :interval_tags
  has_many :tags, :through => :interval_tags
end
