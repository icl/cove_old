class IntervalTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :interval
end
