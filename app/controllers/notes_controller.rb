class NotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_nda
  
  def index
    @notes = Project.find(params[:project_id]).notes
  end
  
  def show
    @project = Note.find(params[:id]).projects.first
    redirect_to(@project)
  end
  
  def new
    @note = Note.new
  end
  
  def create
    @note = Note.new(params[:note])
    @note.projects += [Project.find(params[:project_id])]
    #@note.note = params[:note]['note']
    
    respond_to do |format|
      if @note.save
        format.html { redirect_to(@note.projects.first) if !request.xhr? }
        format.js { @project = Project.find(params[:project_id]) }
      else
        format.html { redirect_to(new_project_notes_path) if !request.xhr? }
        format.js
      end
    end
  end
  
  def edit
    @note = Note.find(params[:id])
  end
  
  def update
    @note = Note.find(params[:id])
    if params[:note][:project_id]
      @note.projects = [Project.find(params[:project_id])]
    end
    
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to(@note.projects.first) if !request.xhr? }
        format.js
      else
        format.html { redirect_to(new_project_notes_path) if !request.xhr? }
        format.js
      end
    end  end
  
  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.html do
        if !request.xhr?
          redirect_to(Project.find(params[:project_id]))
        else
          render :nothing => true
        end
      end
      format.js { render :nothing => true }
    end
  end
  
end
