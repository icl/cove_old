require 'spec_helper'
require "ruby-debug"
describe InvitationsController do
  before(:each) do
    @user = Factory(:admin_user)
    @user.save
    sign_in @user
  end
  
  context "admin is not loggedin" do
    before(:each) do
      sign_out @user
      get :new
    end
    it {should redirect_to("/login")}
  end
  
  context "admin is logged in" do
    
    describe "GET 'new'" do
      before(:each) do
        get :new
      end
      it {should render_template(:new)}
      it {should respond_with(:success)}
    end

    describe "POST 'create'" do
      before(:each) do
        @old_count = User.count
        post :create, :email => "invite@devise.com"
      end
      it {should redirect_to(:action => "new")}
      it {should set_the_flash.to("The user has been sent an invitation")}
      it "should create a new user" do
        User.count.should == (@old_count + 1)
      end
    end
  end  
  
  describe "GET 'edit'" do
    context "valid token" do
      before(:each) do
        User.expects(:invitation_token_valid?).returns(true)
        get :edit, :id => 1 
      end
      it {should respond_with(:success)}
      it {should render_template(:edit)}
    end
  end
end
