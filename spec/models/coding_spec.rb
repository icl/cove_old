require 'spec_helper'

describe Coding do
  before(:each) do
    @code = Factory(:code)
    @user = Factory(:regular_user)
    @interval = Factory(:interval)
  end
  describe "validation" do
    it "should validate presence of interval" do
     lambda{Coding.create! :name => "Test", :user => @user}.should raise_exception 
    end
    it "should validate presence of user" do
      lambda{Coding.create! :name => "Test", :interval => @interval}.should raise_exception 
    end
  end

  describe "#hockup_code" do
    context "valid name" do
      it "should create the necessary association" do
        new_coding = Coding.create :name => "Test", :user => @user, :interval => @interval, :coding_type => "phenomenon"  
        new_coding.should be
        new_coding.code.name.should == "Test"
      end
    end
    context "invalid name" do
      it "should not create a coding" do
        new_coding = Coding.create :name => "wrong", :user => @user, :interval => @interval
        new_coding.save().should be_false
        Coding.count().should be == 0
      end   
    end
    context "code already set" do
      before(:each) do
        @new_coding = Coding.create :user => @user, :interval => @interval, :code => @code
      end
      it {@new_coding.code.should == @code}
      it {Coding.count().should be > 0}
    end
  end
end
