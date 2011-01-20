class User < ActiveRecord::Base
	validates :fname,  :presence => true
	validates :lname, :presence => true
	validates :email, :presence => true,
					  :length => { :minimum => 5 }
end
