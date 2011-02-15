class Commenting < ActiveRecord::Base
  belongs_to :user
  belongs_to :interval
  belongs_to :comment
end
