class Admin::UsersController < ApplicationController
  before_filter :require_admin
  before_filter :authenticate_user!
  def index
    @all_users = ::User.all
    render 'index'
  end
  
  def new
    render 'new'
  end
end
