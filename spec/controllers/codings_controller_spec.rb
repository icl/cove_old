require 'spec_helper'

describe CodingsController do
  before(:each) do
    @interval = Factory(:interval)
    @user = Factory(:admin_user)
    Factory(:code, :name => "test")
    sign_in @user
  end
  describe "POST 'create'" do
    context "succeeded in saving to db" do
      before(:each) do
        post :create, :format => :json, :interval_id => @interval, 
          :coding => {:name => "test", :coding_type => "phenomenon"}
      end
      it {should respond_with 201}
      it "should return the new object in the json body" do
        returned_json = JSON.parse(response.body)
        returned_json["codeName"].should be
        returned_json["codeID"].should be
        returned_json["coding"].should be
      end
    end

    context "failed to save tag" do
      before(:each) do
        post :create, :format => :json, :interval_id => @interval, :coding=> {:name => nil}
      end
      it {should respond_with 422}
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @coding= Factory(:coding, :name => "test")
      @interval = @coding.interval
      get :show, :id => @coding.id, :interval_id => @interval.id
    end
    it {should respond_with :success}
    it {should render_template 'show'}
  end
  
end
