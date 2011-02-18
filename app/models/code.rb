class Code < ActiveRecord::Base
  has_many :codings

  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name
  validates_presence_of :coding_type
end
