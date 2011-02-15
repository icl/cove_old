class DefinitionsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :require_nda

  def index
  end

  def show
    @record = Phenomenon.find_by_name(params[:id])

    render 'show'
  end

  def new
  end
  
end

