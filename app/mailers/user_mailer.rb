class UserMailer < ActionMailer::Base
  default :from => "notifications@irvinxps.com"
 
  def welcome_email(user)
    @user = user
    @url  = "localhost:3000/"
    mail(:to => user.email,
         :subject => "Welcome to my Site")
  end
 
end