class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
  belongs_to :interval

  validates_presence_of :interval_id
  validates_presence_of :user_id
  validates_presence_of :tag_id
end
