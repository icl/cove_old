class PlaceHolderController < ApplicationController
  before_filter :require_nda
  def index
    render "index"
  end
end
