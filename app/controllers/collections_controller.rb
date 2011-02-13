class CollectionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @collections = Collections.find_by_user_id(current_user.id)
    respond_to |format| do
      format.html { render 'index.html' }
    end
  end
  
  def show
    @collection = Collection.find(params[:id])
  end

  def new
    @collection = Collection.new
  end
  
  def edit
    @collection = Collection.find(params[:id])
  end
  
  def create
    @collection = Collection.new(params[:collection])
  end
  
  def update
    # If owner, edit, else clone
    if Collection.find(params[:id]).user_id  == current_user.id
      @collection = Collection.find(params[:id])
    else
      @collection = Collection.new(params[:collection])
    end
  end
  
  def add
    if Collection.find(params[:id]).user_id == current_user.id
    # params[:id] = Collection_id, params[:interval] = Interval_id
      @collection = Collection.find(params[:id])
      @interval = Interval.find_by_id(params[:interval])
      @collection.intervals += [@interval]
      notice = "Interval was added successfully"
    else
      notice = "Interval was not added to collection: Permission Denied."
    end
  end
  
  def remove
    if Collection.find(params[:id]).user_id == current_user.id
    # params[:id] = Collection_id, params[:interval] = Interval_id
      @collection = Collection.find(params[:id])
      @interval = Interval.find_by_id(params[:interval])
      @collection.intervals -= [@interval]
      notice = "Interval was removed successfully"
    else
      notice = "Interval was not removed from collection: Permission Denied."
    end
  end  
  
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    respond_to |format| do
      format.html { redirect_to(collections_url) }
    end
  end
  
end
