class Taging < ActiveRecord::Base
  belongs_to :user
  belongs_to :interval
  belongs_to :tag
end
