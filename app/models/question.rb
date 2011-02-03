class Question < ActiveRecord::Base
  has_many :questionings

  def self.can_be_created?
    true
  end
end
