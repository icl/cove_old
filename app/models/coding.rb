class Coding < ActiveRecord::Base
  belongs_to :code
  belongs_to :user
  belongs_to :interval

  validates_presence_of :user_id
  validates_presence_of :interval_id
  validates_presence_of :code_id

  #instance variables to hold the underlying code properties
  attr_accessor :name
  attr_accessor :coding_type


  before_validation :hookup_code

  scope :phenomenon, lambda {joins(:code).where("codes.coding_type = ?", "phenomenon")}
  scope :people, lambda {joins(:code).where("codes.coding_type = ?", "people")}

  private 
  # Method that will hook up our coding to the underlying 
  # code object if one can be found given @name and @coding_type
  def hookup_code
    #break out of this function if we already have a code set
    return true if self.code

    #if there is not already a code set then go ahead and set it
    this_code = Code.where(:name => self.name, :coding_type => self.coding_type).first
    if this_code
      self.code = this_code
    else
      return false
    end
  end

end
