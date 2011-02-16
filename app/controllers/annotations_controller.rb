class AnnotationsController < ApplicationController
  respond_to :html, :json
  before_filter :find_interval
  def index
    @annotations = @interval.annotations.all(params[:type])
    respond_with(@annotations)
  end


  def find_interval
    @interval = Interval.find(params[:interval_id])
  end
  private :find_interval
end
