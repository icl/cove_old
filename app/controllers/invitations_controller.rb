class InvitationsController < ApplicationController
  before_filter :authenticate_user!
  def new
    render :action => "new"
  end
end
