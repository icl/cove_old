class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  
   def new 
      #render :text => "In show"
      @project = Project.new   
 
      respond_to do |format|
         format.html # new.html.erb
         format.xml  { render :xml => @project }
      end
   end

  def index 
      if user_signed_in?
         @project = Project.all
      end
  end

  # GET /project/1
  # GET /project/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end


  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /project/1/edit
  def edit
    @project = Project.find(params[:id])

  end

  # DELETE /project/1
  # DELETE /project/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(@project, :notice => 'Project was successfully deleted.') }
      format.xml  { head :ok }
    end
  end

  # PUT /intervals/1
  # PUT /intervals/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interval.errors, :status => :unprocessable_entity }
      end
    end
  end

end
