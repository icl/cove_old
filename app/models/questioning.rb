class Questioning < ActiveRecord::Base
  belongs_to :user
  belongs_to :interval
  belongs_to :question
end
