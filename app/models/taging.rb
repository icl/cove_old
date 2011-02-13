class Taging < ActiveRecord::Base
  belongs_to :user
  belongs_to :interval
  belongs_to :tag
  has_and_belongs_to_many :collections
end
