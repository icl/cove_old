class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @project = Project.all
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
