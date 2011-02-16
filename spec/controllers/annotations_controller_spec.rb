require 'spec_helper'

describe AnnotationsController do
  before(:each) do
    @taging = Factory(:taging)
  end
  describe "GET 'index'" do
    context "format json" do
      it "should return all annotations" do
        perform_get(:json)
        response.body.should == Annotation.all(:tag).to_json
      end
    end
  end
  def perform_get(format_type)
    get :index, :format => format_type,
      :interval_id => @taging.interval_id, :type => :tag
    
  end
end
