class Annotation
  @@types_of_annotation = [:tag, :interval]
  include ActiveModel::Validations
  attr_accessor :user_id, :interval_id
  validates_presence_of :user_id
  validates_presence_of :interval_id
  
  def initialize(args)
    @user_id = args[:user_id]
    @interval_id = args[:interval_id]
  end
  
  def all(class_symbol=:all)
    if class_symbol == :all
      self.fetch_all
    else
      Annotation.class_from_symbol(class_symbol).all
    end
  end
  
  def self.class_from_symbol(symbol)
    symbol.to_s.capitalize.constantize
  end
  
  def fetch_all
    result = []
    @@types_of_annotation.each do |type|
      tmp = Annotation.class_from_symbol(type).all
      result << tmp
    end
    return result
  end
  
end
