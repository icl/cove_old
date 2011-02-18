class AnnotationsController < ApplicationController
  respond_to :html, :json
  before_filter :find_interval
  def index
    @annotations = @interval.annotations.all(params[:type])
    respond_with(@annotations)
  end

  def create
    if new_annotation = Annotation.add(:type => params[:type].to_sym, 
                    :invterval => @interval, 
                   :user => current_user, :name => params[:name],
                     :opt => params[:opt])
      flash[:notice] = "You have successfully created a new annotation"
    end
    respond_with do |format|
      format.html {redirect_to :action => "index"}
      format.json { render :json => new_annotation}
    end
  end
  private
  def find_interval
    @interval = Interval.find(params[:interval_id])
  end
end
