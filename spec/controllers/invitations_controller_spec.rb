require 'spec_helper'
describe InvitationsController do
  before(:each) do
    sign_in_as :admin_user
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
    context "invalid token" do
      before(:each) do
        User.expects(:invitation_token_valid?).returns(false)
        get :edit, :id => 1
      end
      it {should redirect_to(root_path)}
      it {should set_the_flash.to("Your Invitation token is not valid")}
    end
  end
  
  describe "PUT 'update'" do
    context "invalid password" do
      before :each do 
        User.expects(:confirm_invitation!).returns(false)
        put :update, :id => 1, :user => {:password => "password",:password_confirmation => "password"}
      end
      it {should set_the_flash}
      it {should redirect_to(:action => "edit")}
    end
    context "valid password" do
      before(:each) do
        User.expects(:confirm_invitation!).returns(true)
        put :update, :id => 1, :user => {:password => "password",:password_confirmation => "password"}
      end
      it {should redirect_to(root_path)}
      it {should set_the_flash}
    end
  end
end
