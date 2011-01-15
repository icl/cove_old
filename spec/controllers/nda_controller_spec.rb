require 'spec_helper'

describe NdaController do
  before(:each) do
    @user = Factory(:first_time_user)
    sign_in @user
  end
  describe "GET 'index'" do
    before(:each) do
      get :index
    end
    it {should respond_with(:success)}
    it {should render_template("index")}
  end
  
  describe "POST 'create'" do
    context "cancel button clicked" do
      before(:each) do
        
      end
    end
  end
end
