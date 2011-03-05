require 'spec_helper'

describe Tagging do
  before(:each) do
    @user = Factory(:regular_user)
    @interval = Factory(:interval)
  end
  describe "validation" do
    it {should validate_presence_of(:user_id)}
    it {should validate_presence_of(:interval_id)}
  end

  describe "#hookup_tag" do
    before(:each) do
      #@tag = Factory(:tag)
      @result = Tagging.create :name => "NewTest", :user => @user, :interval => @interval  
    end
    context "valid tag info" do
      it {@result.should be_true}
      it "should link it to an underlying tag" do
        @result.tag.should be
      end
      it "should create an underlying tag" do
        Tag.where(:name => "NewTest").length().should be > 0
      end
    end
  end

  describe ".tags_with_same_name" do
    before(:each) do
      @tag = Factory(:tagging)
      Factory(:tagging)
      @result = @tag.tags_with_same_name
    end
    it "should return 2 instances of tag" do
      Tagging.count.should == 2
      @result.length().should == 2
    end
    it "should be in instance of tagging" do
      @result[0].should be_instance_of(Tagging)
    end
  end
end
