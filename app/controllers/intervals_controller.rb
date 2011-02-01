class IntervalsController < ApplicationController
    before_filter :authenticate_user!
	# GET /intervals
	# GET /intervals.xml
	def index
		@angles = Interval.unique_angles
		@days = Interval.unique_days

		date_filter = (params[:date].nil? || params[:date] == "") ? false : params[:date]
		conditions = []
		unless(params[:camera_angle].nil? || params[:camera_angle] == "")
			conditions = ["camera_angle = ?", params[:camera_angle]]
		end
		@intervals = Interval.find(:all, :conditions => conditions, :order => "start_time").reject{|row| date_filter && date_filter != row.day} & Interval.lame_search(params[:search])

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @intervals }
		end
	end

  # GET /intervals/1
  # GET /intervals/1.xml
  def show
    @interval = Interval.find(params[:id])
    @tags = Tag.all

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
    @interval.attributes = {'tag_ids' => []}.merge(params[:interval] || {})

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
