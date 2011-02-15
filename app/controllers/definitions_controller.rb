class DefinitionsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :require_nda

  def show
    @term = Phenomenon.find_by_name(params[:id])
    @name = @term.id
    @definition = @term.description

    render 'show'
  end
end

