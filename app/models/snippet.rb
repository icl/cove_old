class Snippet < ActiveRecord::Base
  validates_presence_of :offset, :duration
  belongs_to :interval
end
