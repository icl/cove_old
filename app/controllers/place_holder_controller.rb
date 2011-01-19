class PlaceHolderController < ApplicationController
  before_filter :authenticate_user!, :require_nda
  def index
    render "index"
  end
end
