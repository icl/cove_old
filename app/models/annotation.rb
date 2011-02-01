class Annotation
  include ActiveModel::Validations
  attr_accessor :user_id, :interval_id
  validates_presence_of :user_id
  validates_presence_of :interval_id
  
  def initialize(args)
    @user_id = args[:user_id]
    @interval_id = args[:interval_id]
  end
  
  def tags
    
  end
end
