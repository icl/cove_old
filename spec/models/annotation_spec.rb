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
  
  describe "#all" do
    it "should fetch all intervals" do
      @user.annotations.all(:interval).should == Interval.all
    end
    
    it "should fetch all tags" do
      @user.annotations.all(:tag).should == Tag.all
    end
    
    it "should return all entries" do
      @user.annotations.all().should == [Tag.all, Interval.all]
    end
    
  end
  
  describe ".class_from_symbol" do
    before(:each) do
      @result = Annotation.class_from_symbol(:interval)
    end
    it {@result.should == Interval}
  end
  
  describe "#add" do
    before(:each) do
      @user.annotations.interval_id = @interval.id
    end
    it "should return a tag" do
      @user.annotations.add(:type => :tag, :name => "Test").should be_true
    end
    
    it "should not return if annotation is invalid" do
      @user.annotations.interval_id = nil
      @user.annotations.add(:type => :tag, :name => "Test").should be_false
    end
    
    it "should return false if contained object can not be created" do
      Tag.any_instance.expects(:save).returns(false)
      @user.annotations.add(:type => :tag, :name => "Test").should be_false
    end
  end
  
  describe "#execute_arbitraty_method" do
    context "valid arguments" do
      it "should execute command on argument class" do
        @user.annotations.execute_arbitraty_method(:class_symbol => :interval, :method_name => :class).should == Class
      end
    end
    context "invalid arguments" do
      it "should raise an exception" do
        begin
          @user.annotations.execute_arbitraty_method(:class_symbol => :interl, :method_name => :class).should raise_error
          fail_with "should have thrown exception"
        rescue
          begin
            @user.annotations.execute_arbitraty_method(:class_symbol => :interval, :method_name => :to_blah).should raise_error          
            fail_with "should have thrown exception"
          rescue 
          end
        end
      end
    end
  end
  
  describe ".class_from_symbol" do
    it "should return the appropriate class" do
      Annotation.class_from_symbol(:tag).should == Taging
    end
    it "should throw and exception do" do
      lambda { Annotation.class_from_symbol(:blah) }.should raise_error()
    end
  end
end
