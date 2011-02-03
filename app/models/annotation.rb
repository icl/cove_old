class Annotation
  @@types_of_annotation = [:tag].to_set
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
      Annotation.join_class_from_symbol(class_symbol).all
    end
  end


  def fetch_all
    result = []
    @@types_of_annotation.each do |type|
      tmp = Annotation.join_class_from_symbol(type).all
      result << tmp
    end
    return result
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


  def annotations_for_user(resource_class)
    resource_class.where(:user_id => self.user_id)
  end

  def annotations_for_interval(resource_class)
    resource_class.where(:interval_id => self.interval_id)
  end

  def where(args)
    Annotation.join_class_from_symbol(args.delete(:class_symbol)).where(args)
  end

  def execute_arbitraty_method(args)
    Annotation.join_class_from_symbol(args[:class_symbol]).send args[:method_name]
  end

  private
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

end
