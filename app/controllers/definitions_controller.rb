class DefinitionsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :require_nda

  def show
    @term = Code.find_by_name(params[:id].downcase)
    if @term.nil?
    else
	    @name = @term.name
	    @definition = @term.description
    end
    render 'show'
  end
end

