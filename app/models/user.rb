require "annotation"
class User < ActiveRecord::Base
  
  has_many :taggings
  has_many :codings
  
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :projects
  
  def self.invite_user!(args)
    token = ActiveSupport::SecureRandom.hex(10)
    newUser = User.new :email => args[:email], :password => token, :password_confirmation => token
    newUser.invitation_token = token
    # newUser.invitation_token_expiration = DateTime.now + 5
    if newUser.save
      InvitationMailer.welcome_email(newUser).deliver
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
  
  def self.confirm_invitation!(password, password_confirmation, token)
    if (current_user = User.user_from_token(token))
      if current_user.reset_password!(password, password_confirmation)
        current_user.invitation_token = nil
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def self.user_from_token(token)
    User.where(:invitation_token => token).first
  end
  
  def name
    email
  end
    
end
