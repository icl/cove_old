class TaggingsController < ApplicationController
  respond_to :html, :json
  def create
    @interval = Interval.find(params[:interval_id])
    @new_tag = Tagging.new(params[:tagging])
    @new_tag.interval = @interval
    @new_tag.user = current_user
    if @new_tag.save
      respond_with do |format|
        format.html {redirect_to interval_path(params[:interval_id])}
        format.json do
          render :json => {"status" => "success", 
            "tagName" => @new_tag.tag.name, "tagging" => @new_tag.to_json}, :status => 201
        end
      end
    else
      respond_with do |format|
        format.html {redirect_to interval_path(params[:interval_id])}
        format.json do
          render :json => {"status" => "failure"}, :status => 422
        end
      end
    end
  end

  def show
    @tags = Tagging.tags_with_same_name(params[:id])
    respond_with(@tags)  
  end
end
