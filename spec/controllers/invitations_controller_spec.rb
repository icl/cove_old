require 'spec_helper'

describe InvitationsController do
  before(:each) do
    @user = Factory(:admin_user)
    @user.save
  end
  
  describe "GET 'new'" do
    context "admin is loggedin" do
      before(:each) do
        sign_in @user
        get :new
      end
      it {should render_template(:new)}
      it {should respond_with(:success)}
    end
    context "admin is not loggedin" do
      before(:each) do
        sign_out @user
        get :new
      end
      it {should redirect_to("/login")}
    end
    
  end
end
