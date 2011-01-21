class InvitationMailer < ActionMailer::Base
  default :from => "from@example.com"
  def welcome_email(user)
    @user = user
    # @url  = url_for(:controller => "invitations", :action => "edit", :id => @user.invitation_token)
    mail(:to => @user.email,
         :subject => "Welcome to my Site")
  end
end
