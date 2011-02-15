class SnippetsController < ApplicationController
  def create
    @interval = Interval.find(params[:interval_id])
    @snippet = @interval.snippets.create(params[:snippet])
    redirect_to interval_path(@interval)
  end  

  def show
    @interval = Interval.find(params[:interval_id])
    @snippet = Snippet.find(params[:id])
    render "intervals/show"
  end
end