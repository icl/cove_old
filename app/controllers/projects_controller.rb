class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_nda

  def index
    @projects = Project.find_all_by_user_id(current_user.id)
    if @projects.blank?
      @project = Project.new
    end
    render "index"
  end

  def new
    @project = Project.new
    @project.user = current_user
    render "new"
  end

  def show
    @project = Project.find(params[:id])
    render "show"
  end


  def create
    @project = Project.new(params[:project])
      
    if @project.save
      ['favorites','queue'].each do |type|
        @collection = Collection.new
        @collection.name = "project_" + @project.id.to_s + "_" + type
        @collection.description = type.humanize + " for " + 'project'.humanize
        @collection.user_id = current_user.id
        @collection.projects += [@project]
        @collection.save
      end
      redirect_to(@project, :notice => 'Project was successfully created.')
    else
      render "new"
    end
  end

  def edit
    @project = Project.find(params[:id])
    render "edit"
  end

  def destroy
    @project = Project.find(params[:id])
    @project.collections.each do |collection|
      if collection.name =~ /project_[0-9]+_(favorites|queue)/i
        collection.destroy
      else
        collection.projects = [];
        collection.save
      end
    end
    @project.destroy
    redirect_to(@project, :notice => 'Project was successfully deleted.')
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to(@project, :notice => 'Project was successfully updated.')
    else
      render "edit"
    end
  end
end
