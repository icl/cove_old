class CollectionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @collections = Collection.find_all_by_user_id(current_user.id)
    respond_to do |format|
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
      priority = YAML.load(@collection.interval_priorities).keys.sort!{|a,b| a.to_i <=> b.to_i}.last.to_i + 1
      new_priority = {"#{priority.to_s}" => @interval.id.to_s}
      new_priorities = YAML.load(@collection.interval_priorities).merge new_priority
      @collection.save
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
      priority = YAML.load(@collection.interval_priorities).select {|k,v| v.to_s == @interval.id}.keys.to_i
      subpriorities = {}
      YAML.load(@collection.interval_priorities).select {|k,v| k > priority}.each do |sk,sv|
        subpriorities[(sk.to_i - 1).to_s] = sv
      end
      last_priority = subpriorities.keys.sort!{|a,b| a.to_i <=> b.to_i}.last.to_i
      new_priorities = YAML.load(@collection.interval_priorities).merge! subpriorities
      new_priorities.delete(last_priority.to_s)
      @collection.interval_priorities = new_priorities
      @collection.save
      notice = "Interval was removed successfully"
    else
      notice = "Interval was not removed from collection: Permission Denied."
    end
  end  
  
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to(collections_url) }
    end
  end
  
end
