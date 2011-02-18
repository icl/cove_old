require 'spec_helper'

describe AnnotationsController do
  #before(:each) do
    ##@taging = Factory(:taging)
  #end
  #describe "GET 'index'" do
    #it "should return all annotations" do
      #perform_get(:json)
      ##response.body.should == (:tag).to_json
    #end
  #end

  #describe "POST 'create'" do
    #it "should create a new taging in the db" do
      #old_count = Annotation.all(:tag).length
      #perform_post
      ##Annotation.all(:tag).length.should be > old_count
    #end
  #end


  #def perform_post
    #post :create, :format => :json, :interval_id => @taging.interval_id, 
      #:type => :tag, :name => "Test"
  #end
  #def perform_get(format_type)
    #get :index, :format => format_type,
      #:interval_id => @taging.interval_id, :type => :tag
  #end
end
