require 'spec_helper'

describe IntervalsController do
  before(:each) do
    sign_in_as :regular_user
  end

  describe "GET 'show'" do
    before(:each) do
      @interval = Factory(:interval)
      @interval.taggings << Factory(:tagging)
      get :show, :id => @interval.id
    end
    it {should respond_with(:success)}
    it {should render_template('show')}
    it {assigns[:applied_tags].should == @interval.taggings}
    it {assigns[:all_people].should == Code.people.all()}
    it {assigns[:applied_people].should == @interval.codes.people}
    it {assigns[:applied_phenomenon].should == @interval.codes.phenomenon}
    it {assigns[:all_phenomenon].should == Code.phenomenon.all()}
  end
    
  describe "GET 'new'" do
    before(:each) do
      get :index
    end
    context "for a regular user" do
      it {should render_template(:index)}
      it {should respond_with(:success)}
    end
  end
end
