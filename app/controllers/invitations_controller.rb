class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  def new
    render :action => "new"
  end
  
  def create
    if User.invite_user!(:email => params[:email] )
      flash[:notice] = "The user has been sent an invitation"
    else
      flash[:alert] = "We could not invite your user at this time"
    end
    redirect_to :action => "new"
  end
  
  def edit
    # if User.invitation_token_valid? params[:id]
    #       render :action => "edit"
    #     else
    #       flash[:alert] = "Your Invitation Token is not valid"
    #       redirect_to(root_path)
    #     end
    render :action => "edit"
  end
end
