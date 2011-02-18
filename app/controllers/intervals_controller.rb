class IntervalsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :require_nda
    before_filter :find_interval, :only => [:show, :update, :edit]
    
	def index
		@camera_angles = Interval.unique_angles
		@days = Interval.unique_days
		@session_types = Interval.unique_session_types
		@phrase_types = Interval.unique_phrase_types
		@phrase_names = Interval.unique_phrase_names

    @intervals = Interval.search params

    render 'index'
  end

  def show
    #@tags = Tag.all
    #@tags = Taging.where :interval_id => @interval.id
    @tags = @interval.annotations.all(:tag)
    #@phenomenon = Phenomenoning.where :interval_id => @interval.id
    @phenomenon = @interval.annotations.all(:phenomenon)
    render "show"
  end

  def new
    @interval = Interval.new
    render "new"
  end

  def edit
    render "edit"
  end


  def create
    @interval = Interval.new(params[:interval])
    if @interval.save
      redirect_to(@interval, :notice => 'Interval was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @interval.attributes = {'tag_ids' => []}.merge(params[:interval] || {})
    
    if @interval.update_attributes(params[:interval])
      redirect_to(@interval, :notice => 'Interval was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /intervals/1
  # DELETE /intervals/1.xml
  def destroy
    @interval = Interval.find(params[:id])
    @interval.destroy
    redirect_to(intervals_url)
  end

  private
  def find_interval
    @interval = Interval.find(params[:id])
  end
end
