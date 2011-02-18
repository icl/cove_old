class Annotation
  @@types_of_annotation = [:tag, :phenomenon, :comment, :question].to_set
  include ActiveModel::Validations
  attr_accessor :user_id, :interval_id
  validates_presence_of :user_id
  validates_presence_of :interval_id

  def initialize(args)
    @user_id = args[:user_id]
    @interval_id = args[:interval_id]
  end
  
  # The Main finder method. Will get the desired Annotations based
  # on the filter
  #
  # @param [Symbol] the annotation type filter. :all will return
  # all Annotations. 
  # @return [Array] an array containing all the annotation objects
  def self.all(type=:all)
    if type == :all
      self.fetch_all
    else
      Annotation.join_class_from_symbol(type).all
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
  
  # Creates a new annotation of the specified type.
  # will first check to see if there is already 
  # a model with the same name. If one is not found
  # then it will attempt to make one.
  # A join model object will also be created 
  # connecting the new instance to the specified 
  # user and interval.
  #
  # Example 
  #   Annotation.add(:type => :tag, :name => "test", :user => current_user,
  #   :interval => Interval.find(params[:id]))
  #
  #   Would create a new tag with the name test as well as a 
  #   new tagging object that connects the tag to the 
  #   current user and the interval that we are viewing. 
  def self.add(args)
    type = args.delete(:type)
    name = args.delete(:name)
    user = args.delete(:user)
    interval = args.delete(:interval)
    resource = Annotation.class_from_symbol(type).where(:name => name).first

    # handle a bad name for the actual model class
    unless resource
      if Annotation.class_from_symbol(type).can_be_created?
        new_resource = Annotation.class_from_symbol(type).new(:name => name)
        if args[:opt]
          args[:opt].keys.each do |key| 
            new_resource.send "#{key}=", args[:opt][key]
          end
        end
        unless new_resource.save
          return false
        end
      else
        return false
      end
    end

    # create the new join model instance.
    new_object = Annotation.join_class_from_symbol(type).new()
    new_object.send "#{type.to_s}=", resource
    new_object.user = user
    new_object.interval = interval
    return new_object.save
  end
  
  #create a new Annotation model and also accompanying join model
  #acts just like add except it does not require you to pass in 
  #objects to user and interval. You can pass in integers instead
  #
  #WARNING DOES NOT CHECK IF IDs ARE VALID COULD CAUSE 
  #BADLY LINKED DATA
  def self.add!(args)
    type = args.delete(:type)
    name = args.delete(:name)
    user = args.delete(:user)
    interval = args.delete(:interval)
    resource = Annotation.class_from_symbol(type).where(:name => name).first

    # handle a bad name for the actual model class
    unless resource
      if Annotation.class_from_symbol(type).can_be_created?
        new_resource = Annotation.class_from_symbol(type).new(:name => name)
        if args[:opt]
          args[:opt].keys.each do |key| 
            new_resource.send "#{key}=", args[:opt][key]
          end
        end
        unless new_resource.save
          return false
        end
      else
        return false
      end
    end

    # create the new join model instance.
    new_object = Annotation.join_class_from_symbol(type).new()
    new_object.send "#{type.to_s}_id=", resource.id
    new_object.user_id = user
    new_object.interval_id = interval
    return new_object.save
 
  end
  # Manipulate the symobl into the appropriate join model class
  # Example
  #   Annotation.join_class_from_symbol(:tag)
  #   
  #   Will return Taging.
  def self.join_class_from_symbol(symbol)
    if @@types_of_annotation.include? symbol
      symbol.to_s.concat("ing").capitalize.constantize
    else
      raise Exception
    end
  end
  
  # Manipulate the symbol into the correct annotaion type class
  # Example
  #   Annotation.class_from_symbol(:tag)
  #   
  #   Will return Tag
  def self.class_from_symbol(symbol)
    if @@types_of_annotation.include? symbol
      symbol.to_s.capitalize.constantize
    else
      raise Exception
    end
  end
  
  # Used the execute a where clause on the specified type
  # Example
  #   Annotation.where(:type => :tag, :email => "ryan@weald.com")
  #
  #   Will execute Tag.where(:name => "test")
  #
  #   and return all tags with a name test
  def self.where(args)
    Annotation.join_class_from_symbol(args.delete(:type)).where(args)
  end

  
  def self.execute_arbitraty_method(args)
    Annotation.join_class_from_symbol(args[:type]).send args[:method_name]
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
