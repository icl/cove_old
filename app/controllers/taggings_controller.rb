class TaggingsController < ApplicationController
  respond_to :html, :json
  def create
    @interval = Interval.find(params[:interval_id])
    @new_tag = Tagging.new(params[:tagging])
    @new_tag.interval = @interval
    @new_tag.save
    respond_with(@new_tag, :location => interval_path(params[:interval_id]))
  end

  def show
    @tags = Tagging.tags_with_same_name(params[:id])
    respond_with(@tags)  
  end
end
