class Interval < ActiveRecord::Base
  has_many :interval_tags, :dependent => :destroy
  has_many :tags, :through => :interval_tags
end
