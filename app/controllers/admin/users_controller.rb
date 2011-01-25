require "ruby-debug"
class Admin::UsersController < ApplicationController
  before_filter :require_admin
  before_filter :authenticate_user!
  def index
    @all_users = ::User.all
    render 'index'
  end
  
  def new
    @error_list = session[:error_list]
    session[:error_list] = nil
    render 'new'
  end
  
  def create
    @error_list = []
    if !params[:user][:email_list].blank?
      email_string = params[:user][:email_list].read
      email_list = email_string.split(",")
      email_list.each do |email|
        if !User.invite_user!(:email => email.strip)
          @error_list << email.strip
        end
      end
    elsif (email = params[:user][:email])
      if !User.invite_user!(:email => email)
        @error_list << email.strip
      end
    else
      flash[:alert] = "The file or email you entered was not valid please try again"
    end
    session[:error_list] = @error_list
    redirect_to :action => "new"
  end
end
