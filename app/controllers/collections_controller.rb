class CollectionsController < ApplicationController
  
  def index
    @collections = Collections.find_by_user_id(current_user.id)
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
    @collection = Collection.find(params[:id])
  end
  
  def add
    # params[:id] = Collection_id, params[:interval] = Interval_id
    @collection = Collection.find(params[:id])
    @interval = Interval.find_by_id(:interval)
    # Join Model Goes Here
  end
  
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
  end
  
end
