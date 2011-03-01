class Tagging < ActiveRecord::Base
  #create the necessary activerecord associations
  belongs_to :tag
  belongs_to :user
  belongs_to :interval
  
  #validations for the all the associations
  validates_presence_of :interval_id
  validates_presence_of :user_id
  validates_presence_of :tag_id

  #instance variables that will hold the name of the underlying tag info
  attr_accessor :name
  validates_presence_of :name
  #the before hook that will create the necessary underlying tag
  before_validation :hookup_tag


  #stupid hack that ethan made
  def tags_with_same_name
    Tagging.tags_with_same_name self.tag.name
  end

  def self.tags_with_same_name a_name
    Tagging.joins(:tag).where("tags.name = ?", a_name)
  end
  #This method will check to see if a tag with a given name already exists
  #and if so create the necessary association. If there is no tag available
  #then we shall create it.
  private
  def hookup_tag
    current_tag = Tag.where(:name => self.name).first
    if current_tag
      self.tag = current_tag
      return true
    else
      begin
        self.tag = create_underlying_tag
        return true
      rescue
        return false
      end
    end
  end

  def create_underlying_tag
    return Tag.create! :name => self.name
  end

end
