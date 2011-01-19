require 'spec_helper'


describe User do
  context "validation" do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
  end
  
  describe ".invite_user!" do
    before(:each) do
      Factory(:regular_user)
    end
    context "unused email address" do
      before(:each) do
        @user = User.invite_user!(:email => "invite@devise.com")
      end
      it {@user.should be}
      it "should set the invitation_token" do
        @user.invitation_token.should be
      end
    end
    
    context "email address already exists" do
      before(:each) do
        @user = User.invite_user!(:email => "user@test.com")
      end
      it {@user.should be_nil}
    end
  end
  
  describe ".invitation_token_valid?" do
    before(:each) do
      @user = User.invite_user!(:email => "invite@devise.com")
      @return_value = User.invitation_token_valid?(@user.invitation_token)
    end
    context "valid token" do
      before(:each) do
        @return_value = User.invitation_token_valid?(@user.invitation_token)
      end
      it{@return_value.should be_true}
    end
    context "invalid token" do
      before(:each) do
        @return_value = User.invitation_token_valid?("bad value")
      end
      it {@return_value.should be_false}
    end
  end
end
