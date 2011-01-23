require "spec_helper"

describe InvitationMailer do
  describe "#welcome_email" do
    before(:each) do
      InvitationMailer.welcome_email(Factory(:invited_user)).deliver
    end
    it "should have sent an email" do
      # @email.deliver
      ActionMailer::Base.deliveries.length().should be > 0
    end
  end
end
