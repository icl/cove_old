class SnippetsController < ApplicationController
  def create
    @interval = Interval.find(params[:interval_id])
    @snippet = @interval.snippets.create(params[:snippet])
    if request.xhr?
      render :partial => "intervals/snippets_list.html.haml", :locals => { :interval => @interval }, :layout => false
    else
      redirect_to interval_path(@interval)
    end
  end  

  def update
    @interval = Interval.find(params[:interval_id])
    @snippet = Snippet.find(params[:id])
    @snippet.update_attributes(params[:snippet])
    if request.xhr?
      render :partial => "intervals/snippets_list.html.haml", :locals => { :interval => @interval }, :layout => false
    else
      redirect_to interval_path(@interval)
    end
  end

  def show
    @interval = Interval.find(params[:interval_id])
    @snippet = Snippet.find(params[:id])
    render "intervals/show"
  end
end
