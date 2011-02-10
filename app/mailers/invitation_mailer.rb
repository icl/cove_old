class InvitationMailer < ActionMailer::Base
  default :from => "NO-REPLY@cove.ucsd.edu"
  def welcome_email(user)
    @user = user
    # @url  = url_for(:controller => "invitations", :action => "edit", :id => @user.invitation_token)
    mail(:to => @user.email,
         :subject => "ICL COVE Invitation")
  end
end
