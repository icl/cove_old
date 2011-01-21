class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  def new
    render :action => "new"
  end

  def create
    if User.invite_user!(:email => params[:email])
      flash[:notice] = "The user has been sent an invitation"
    else
      flash[:alert] = "We could not invite your user at this time"
    end
    redirect_to :action => "new"
  end

  def edit
    if User.invitation_token_valid? params[:id]
      @user = User.new
      render :action => "edit"
    else
      flash[:alert] = "Your Invitation token is not valid"
      redirect_to(root_path)
    end
  end

  def update
    if !User.confirm_invitation!(params[:user][:password], params[:user][:password_confirmation], params[:id])
      flash[:alert] = "Your password was invalid please try again"
      return redirect_to :action => "edit"
    else
      flash[:notice] = "You are now on official user"
      # authenticate_user! User.user_from_token
      # redirect_to(root_path)
      sign_in_and_redirect :user, User.user_from_token(params[:id])
    end
  end
end
