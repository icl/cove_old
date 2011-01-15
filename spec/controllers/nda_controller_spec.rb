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
    context "check box is clicked" do
      before(:each) do
        post :create, :accept => 1
      end
      it {should redirect_to(root_path)}
      it "should update current users nda_signed property" do
        User.find(@user.id).nda_signed.should be_true
      end
    end
    
    context "check box is unchecked" do
      before(:each) do
        post :create, :accept => 0
      end
      it {should redirect_to(nda_path)}
      it {should set_the_flash.to("You must accept NDA to continue")}
    end
  end
end
