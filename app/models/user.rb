class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def self.invite_user!(args)
    token = ActiveSupport::SecureRandom.base64(10)
    newUser = User.new :email => args[:email], :password => token, :password_confirmation => token
    newUser.invitation_token = token
    # newUser.invitation_token_expiration = DateTime.now + 5
    if newUser.save
      return newUser
    else
      return nil
    end
  end
  
  def self.invitation_token_valid?(token)
    if User.where(:invitation_token => token).first
      return true
    else
      return false
    end
  end
  
end
