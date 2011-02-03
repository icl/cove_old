class Annotation
  @@types_of_annotation = [:tag, :phenomenon].to_set
  include ActiveModel::Validations
  attr_accessor :user_id, :interval_id
  validates_presence_of :user_id
  validates_presence_of :interval_id

  def initialize(args)
    @user_id = args[:user_id]
    @interval_id = args[:interval_id]
  end

  def self.all(class_symbol=:all)
    if class_symbol == :all
      self.fetch_all
    else
      Annotation.join_class_from_symbol(class_symbol).all
    end
  end

  
  def self.fetch_all
    result = []
    @@types_of_annotation.each do |type|
      tmp = Annotation.join_class_from_symbol(type).joins(type)
      result << tmp
    end
    return result
  end
  
  def self.add(args)
    type = args.delete(:type)
    name = args.delete(:name)
    resource = Annotation.class_from_symbol(type).where(:name => name).first

    # handle a bad name for the actual model class
    unless resource
      if Annotation.class_from_symbol(type).can_be_created?
        unless Annotation.class_from_symbol(type).create(:name => name)
          return false
        end
      else
        return false
      end
    end

    # create the new join model instance.
    new_object = Annotation.join_class_from_symbol(type).new(args)
    new_object.send "#{type.to_s}=", resource
    new_object.user = args[:user]
    new_object.interval = args[:interval]
    return new_object.save
  end
  
  def self.join_class_from_symbol(symbol)
    if @@types_of_annotation.include? symbol
      symbol.to_s.concat("ing").capitalize.constantize
    else
      raise Exception
    end
  end

  def self.class_from_symbol(symbol)
    if @@types_of_annotation.include? symbol
      symbol.to_s.capitalize.constantize
    else
      raise Exception
    end
  end
  
  def self.where(args)
    Annotation.join_class_from_symbol(args.delete(:class_symbol)).where(args)
  end

  
  def self.execute_arbitraty_method(args)
    Annotation.join_class_from_symbol(args[:class_symbol]).send args[:method_name]
  end
  
  
  
  
  # DEPRECATED METHOD YOU SHOULD USE THE CLASS METHOD INSTEAD
  # def add(args)
  #   if self.valid?
  #     type = args.delete(:type)
  #     name = args.delete(:name)
  #     resource = Annotation.class_from_symbol(type).where(:name => name).first
  # 
  #     # handle a bad name for the actual model class
  #     unless resource
  #       if Annotation.class_from_symbol(type).can_be_created?
  #         unless Annotation.class_from_symbol(type).create(:name => name)
  #           return false
  #         end
  #       else
  #         return false
  #       end
  #     end
  # 
  #     # create the new join model instance.
  #     new_object = Annotation.join_class_from_symbol(type).new(args)
  #     new_object.send "#{type.to_s}=", resource
  #     new_object.user = self.user_id
  #     new_object.interval = self.interval_id
  #     return new_object.save
  #   else
  #     return false
  #   end
  # end

  # class version of the add method. Needs a user_id, interval_id
  # annotation type, name, and any additional arguments
  
  def all(symbol)
    if self.user_id && self.interval_id
      result = self.annotations_for_user_and_interval(Annotation.join_class_from_symbol(symbol), Annotation.class_from_symbol(symbol))
    else
      if self.user_id
        result= self.annotations_for_user(Annotation.join_class_from_symbol(symbol), Annotation.class_from_symbol(symbol))
      end

      if self.interval_id
        result =  self.annotations_for_interval(Annotation.join_class_from_symbol(symbol), Annotation.class_from_symbol(symbol))
      end
    end
    return result
  end

  protected
  def annotations_for_user(join_class, resource_class)
    join_class.joins(resource_class.to_s.downcase.to_sym).where(:user_id => @user_id)
  end

  def annotations_for_interval(join_class,resource_class)
    join_class.joins(resource_class.to_s.downcase.to_sym).where(:interval_id => @interval_id)
  end
  
  def annotations_for_user_and_interval(join_class, resource_class)
    join_class.joins(resource_class.to_s.downcase.to_sym).where(:interval_id => @interval_id).where(:user_id => @user_id)    
  end
  
end
