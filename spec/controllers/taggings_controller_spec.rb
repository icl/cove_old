require 'spec_helper'

describe TaggingsController do
  before(:each) do
    @interval = Factory(:interval)
    @user = Factory(:admin_user)
    sign_in @user
  end
  describe "POST 'create'" do
    context "succeeded in saving to db" do
      before(:each) do
        post :create, :format => :json, :interval_id => @interval, 
          :tagging => {:name => "test"}
      end
      it {should respond_with 201}
      it "should return the new object in the json body" do
        returned_json = JSON.parse(response.body)
        returned_json["tagName"].should be
      end
    end

    context "failed to save tag" do
      before(:each) do
        post :create, :format => :json, :interval_id => @interval, :tagging => {:name => nil}
      end
      it {should respond_with 422}
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @tagging = Factory(:tagging)
      @interval = @tagging.interval
      get :show, :id => @tagging.id, :interval_id => @interval.id
    end
    it {should respond_with :success}
    it {should render_template 'show'}
  end
end
