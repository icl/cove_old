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

    search = Interval.search_with params
    @intervals = search.results

    render 'index'
  end

  def show
    @tags = @interval.taggings
    @phenomenon = @interval.codings.phenomenon
    @people = @interval.codings.people

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
