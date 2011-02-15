class DefinitionsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :require_nda

  def show
    @term = Phenomena.find_by_name(params[:id])
    @definition = @term.description

    render 'show'
  end
end

