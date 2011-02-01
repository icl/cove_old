require 'spec_helper'

describe Annotation do
  before(:each) do
    @user = Factory(:regular_user)
    @interval = Factory(:interval)
  end
  
  context "validations" do
    it {@user.annotations.valid?().should be_false}
    it {@interval.annotations.valid?().should be_false}
    it "should be valid after additional parameter" do
      @user.annotations.interval_id = @interval.id
      @user.annotations.valid?().should be_true
      @interval.annotations.user_id = @user.id
      @interval.annotations.valid?().should be_true
    end
  end
  
  describe ".initialize" do
    it {@user.annotations.user_id.should be}
    it {@interval.annotations.interval_id.should be}
  end
  
  describe "#tags" do
    
  end
end
