class Coding < ActiveRecord::Base
  belongs_to :code
  belongs_to :user
  belongs_to :interval

  validates_presence_of :user_id
  validates_presence_of :interval_id
  validates_presence_of :code_id
end
