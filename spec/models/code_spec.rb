require 'spec_helper'

describe Code do
  before(:each)do
    Factory(:code)
    Factory(:coding)
  end
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:coding_type)}
    it {should validate_uniqueness_of(:name)}
  end

  describe "scope unapplied" do
    before(:each) do
      @new_interval = Factory(:interval)
      Interval.count.should be > 1
    end
    it "should return a list of unapplied codes" do
      Code.unapplied(@new_interval.id).should == Code.all()
    end
  end

  describe "scope phenomenon" do
    it "should return all the phenomenon" do
      Code.phenomenon().should == Code.where(:coding_type => "phenomenon")
    end

  end
end
