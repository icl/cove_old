require "spec_helper"

describe IntervalsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/intervals" }.should route_to(:controller => "intervals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/intervals/new" }.should route_to(:controller => "intervals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/intervals/1" }.should route_to(:controller => "intervals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/intervals/1/edit" }.should route_to(:controller => "intervals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/intervals" }.should route_to(:controller => "intervals", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/intervals/1" }.should route_to(:controller => "intervals", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/intervals/1" }.should route_to(:controller => "intervals", :action => "destroy", :id => "1")
    end

  end
end
