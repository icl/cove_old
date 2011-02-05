class IntervalsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @angles = Interval.unique_angles
    @days = Interval.unique_days

    date_filter = (params[:date].nil? || params[:date] == "") ? false : params[:date]
    conditions = []
    unless(params[:camera_angle].nil? || params[:camera_angle] == "")
      conditions = ["camera_angle = ?", params[:camera_angle]]
    end
    @intervals = Interval.find(:all, :conditions => conditions, :order => "start_time").reject{|row| date_filter && date_filter != row.day} & Interval.lame_search(params[:search])

    render 'index'
  end

  def show
    @interval = Interval.find(params[:id])
    @tags = Tag.all

    render "show"
  end

  def new
    @interval = Interval.new
    render "new"
  end

  def edit
    @interval = Interval.find(params[:id])
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
    @interval = Interval.find(params[:id])
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
end
