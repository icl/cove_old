class InvitationMailer < ActionMailer::Base
  default :from => "from@example.com"
  def welcome_email(user)
    @user = user
    @url  = "localhost:3000/"
    mail(:to => @user.email,
         :subject => "Welcome to my Site")
  end
end
