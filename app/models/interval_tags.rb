class IntervalTags < ActiveRecord::Base
  belongs_to :tag
  belongs_to :interval
  validates_presence_of :tag_id
  validates_presence_of :interval_id  
end
