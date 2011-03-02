class CollectionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_nda
  
  def index
    @collections = Collection.find_all_by_user_id(current_user.id)
    respond_to do |format|
      format.html { render 'index.html' }
    end
  end
  
  def show
    if request.url =~ /(favorite|queue)/i
      type = request.url =~ /favorite/i ? "favorites" : "queue"
      owner = request.url =~ /project/i ? "project" : "user"
      @name = owner + "_" + params[:id].to_s + "_" + type
      @collection = Collection.find_by_name_and_user_id(@name,current_user.id)
    else
      @collection = Collection.find(params[:id])
      if @collection.name =~ /(project|user)_[0-9]+_(favorites|queue)/i
        type = @collection.name =~ /favorite/i ? "favorites" : "queue"
        owner = @collection.name =~ /project/i ? "projects" : "users"
        id = @collection.name.split('_')[1]
        link = '/' + owner + '/' + id.to_s + '/' + type
        redirect_to(link)
      end
    end
  end

  def new
    @collection = Collection.new
  end
  
  def edit
    @collection = Collection.find(params[:id])
  end
  
  def create
    @collection = Collection.new(params[:collection])
    if @collection.save
      redirect_to(@collection, :notice => 'Collection was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def update
    # If owner, edit, else clone
    if Collection.find(params[:id]).user_id  == current_user.id
      @collection = Collection.find(params[:id])
    else
      @collection = Collection.new(params[:collection])
    end
    if @collection.update_attributes(params[:collection])
      redirect_to(@collection, :notice => 'Interval was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def prioritize_interval #parameters :id => collection_id, :interval => interval_id
    if request.url =~ /(favorite|queue)/i
      type = request.url =~ /favorite/i ? "favorites" : "queue"
      owner = request.url =~ /project/i ? "project" : "user"
      name = owner + "_" + params[:id].to_s + "_" + type
      @collection = Collection.find_by_name_and_user_id(name,current_user.id)
      if @collection.nil?
        @collection = Collection.new
        @collection.name = owner + "_" + params[:id].to_s + "_" + type
        @collection.desc = type.humanize + " for " + owner.humanize
        @collection.user_id = current_user.id
        if owner =~ /project/
          @collection.projects += [Project.find(params[:id])]
        end
        @collection.save
      end
    else
      @collection = Collection.find(params[:id])
    end
    priority_list = YAML.load(@collection.interval_priorities)
    priority = priority_list.select {|k,v| v == params[:interval]}[0][0].to_i rescue nil
    if priority.blank?
      notice = "Interval does not exist in collection"
    else
      if params[:direction] == "up"
        new_priority = priority - 1
      elsif params[:direction] == "down"
        new_priority = priority + 1
      else
        new_priority = 0
      end
      if new_priority == 0 || new_priority > priority_list.count
        notice = "Error: Invalid priority"
      else
        d_interval = priority_list[new_priority.to_s]
        priority_list[priority.to_s] = d_interval
        priority_list[new_priority.to_s] = params[:interval]
        @collection.interval_priorities = priority_list.to_yaml
        @collection.save
        notice = "Priority of interval was successfully edited"
      end
    end
    if request.xhr?
      render :text => (notice =~ /error/i) ? "failed" : "success"
    else
      redirect_to(@collection, :notice => notice)
    end
  end
  
  def prioritize_intervals
    @collection = Collection.find(params[:id])
    # Save Priorities from jQuery Sortable List via POST
    # JSON Input has a trailing comma. So JSON parser is: ActiveSupport::JSON.decode(params[:priority].gsub(/,\}/,'}'))
    @collection.interval_priorities = ActiveSupport::JSON.decode(params[:priority].gsub(/,\}/,'}')).to_yaml
    @collection.save
    notice = "Interval Priorities have been saved"
    #redirect_to(@collection, :notice => notice)
    render :nothing => true
  end
  
  def add
    if request.url =~ /(favorite|queue)/i
      type = request.url =~ /favorite/i ? "favorites" : "queue"
      owner = request.url =~ /project/i ? "project" : "user"
      name = owner + "_" + params[:id].to_s + "_" + type
      @collection = Collection.find_by_name_and_user_id(name,current_user.id)
      if @collection.nil?
        @collection = Collection.new
        @collection.name = owner + "_" + params[:id].to_s + "_" + type
        @collection.description = type.humanize + " for " + owner.humanize
        @collection.user_id = current_user.id
        if owner =~ /project/
          @collection.projects += [Project.find(params[:id])]
        end
        @collection.save
      end
    else
      @collection = Collection.find(params[:id])
    end
    
    if @collection.user_id == current_user.id
      if !@collection.intervals.collect{|i| i.id.to_s }.include? params[:interval].to_s
        # params[:id] = Collection_id, params[:interval] = Interval_id
        @interval = Interval.find_by_id(params[:interval])
        if !@collection.intervals.blank?
          priority = YAML.load(@collection.interval_priorities).keys.sort!{|a,b| a.to_i <=> b.to_i}.last.to_i + 1
          new_priority = {"#{priority.to_s}" => @interval.id.to_s}
          new_priorities = YAML.load(@collection.interval_priorities).merge new_priority
        else
          new_priorities = {'1' => @interval.id.to_s}
        end
        @collection.interval_priorities = new_priorities.to_yaml
        @collection.intervals += [@interval]
        @collection.save
        notice = "Interval was added successfully"
      else
        notice = "Error: Interval is already in collection"
      end
    else
      notice = "Error: Interval was not added to collection: Permission Denied."
    end
    if request.xhr?
      render :text => (notice =~ /error/i) ? "failed" : "success"
    else
      redirect_to(@collection, :notice => notice)
    end
  end
  
  def remove
    if request.url =~ /(favorite|queue)/i
      type = request.url =~ /favorite/i ? "favorites" : "queue"
      owner = request.url =~ /project/i ? "project" : "user"
      name = owner + "_" + params[:id].to_s + "_" + type
      @collection = Collection.find_by_name_and_user_id(name,current_user.id)
      if @collection.nil?
        @collection = Collection.new
        @collection.name = owner + "_" + params[:id].to_s + "_" + type
        @collection.description = type.humanize + " for " + owner.humanize
        @collection.user_id = current_user.id
        if owner =~ /project/
          @collection.projects += [Project.find(params[:id])]
        end
        @collection.save
      end
    else
      @collection = Collection.find(params[:id])
    end

    if @collection.user_id == current_user.id && !@collection.intervals.blank?
    # params[:id] = Collection_id, params[:interval] = Interval_id
      @interval = Interval.find_by_id(params[:interval])
      if @collection.intervals.include? @interval
        @collection.intervals -= [@interval]
        priority = YAML.load(@collection.interval_priorities).select {|k,v| v.to_i == @interval.id}[0][0].to_i
        subpriorities = {}
        YAML.load(@collection.interval_priorities).select {|k,v| k.to_i > priority}.each do |sk,sv|
          subpriorities[(sk.to_i - 1).to_s] = sv
        end
        last_priority = YAML.load(@collection.interval_priorities).keys.sort!{|a,b| a.to_i <=> b.to_i}.last.to_i
        new_priorities = YAML.load(@collection.interval_priorities).merge! subpriorities
        new_priorities.delete(last_priority.to_s)
        @collection.interval_priorities = new_priorities.to_yaml
        @collection.save
        notice = "Interval was removed successfully"
      else
        notice = "Interval does not exist in collection"
      end
    else
      notice = "Error: Interval was not removed from collection: Permission Denied."
    end
    if request.xhr?
      render :text => (notice =~ /error/i) ? "failed" : "success"
    else
      redirect_to(@collection, :notice => notice)
    end
  end  
  
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to(collections_url, :notice => 'Collection was successfully deleted.') }
    end
  end
  
end
