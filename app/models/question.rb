class Question < ActiveRecord::Base
  has_many :questionings
  has_many :answers

  def self.can_be_created?
    true
  end
end
