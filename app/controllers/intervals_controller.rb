class IntervalsController < ApplicationController
  # GET /intervals
  # GET /intervals.xml
  def index
    intervals = Interval.find(:all, :order => 'start_time').map{|int|
    	# Derive a "duration" field from the start and end times.
	duration = (int.end_time - int.start_time)
	hours = (duration / (60*60)).floor
	minutes = ((duration - hours*60*60)/60).floor
	int[:duration] = sprintf("%02dh%02dm", hours, minutes);
	int
    }.map{|int|
	# Derive a "day" field from the start time.
	int[:day] = sprintf("%d-%d-%d", int.start_time.month, int.start_time.day, int.start_time.year)
	int
    }.map{|int|
	# Derive a "start_time_of_day" field from the start time
	int[:start_time_of_day] = sprintf("%02d:%02d %s", int.start_time.hour % 12, int.start_time.min, (int.start_time.hour / 12).floor == 0 ? "AM" : "PM")
	int
    }

    # Build arrays of the unique angles and days.
    @angles = intervals.map {|x| x.camera_angle}.uniq.sort
    @days = intervals.map{|x| x.start_time}.map {|x|
	sprintf("%d-%d-%d", x.month, x.day, x.year)
    }.uniq

    # Filter by the passed parameters
    @filtered_intervals = intervals.reject{|x|
    	if(params[:date].nil? || params[:date] == "")
		false
	else
		day = sprintf("%d-%d-%d", x.start_time.month, x.start_time.day, x.start_time.year)
		params[:date] != day
	end
    }.reject{|x|
    	if(params[:camera_angle].nil? || params[:camera_angle] == "")
		false
	else
		params[:camera_angle] != x.camera_angle
	end
    }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @filtered_intervals }
    end
  end

  # GET /intervals/1
  # GET /intervals/1.xml
  def show
    @interval = Interval.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interval }
    end
  end

  # GET /intervals/new
  # GET /intervals/new.xml
  def new
    @interval = Interval.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @interval }
    end
  end

  # GET /intervals/1/edit
  def edit
    @interval = Interval.find(params[:id])
  end

  # POST /intervals
  # POST /intervals.xml
  def create
    @interval = Interval.new(params[:interval])

    respond_to do |format|
      if @interval.save
        format.html { redirect_to(@interval, :notice => 'Interval was successfully created.') }
        format.xml  { render :xml => @interval, :status => :created, :location => @interval }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interval.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /intervals/1
  # PUT /intervals/1.xml
  def update
    @interval = Interval.find(params[:id])

    respond_to do |format|
      if @interval.update_attributes(params[:interval])
        format.html { redirect_to(@interval, :notice => 'Interval was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interval.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /intervals/1
  # DELETE /intervals/1.xml
  def destroy
    @interval = Interval.find(params[:id])
    @interval.destroy

    respond_to do |format|
      format.html { redirect_to(intervals_url) }
      format.xml  { head :ok }
    end
  end
end
