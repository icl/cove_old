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
end
