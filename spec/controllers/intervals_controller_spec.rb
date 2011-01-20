require 'spec_helper'

describe IntervalsController do
  before(:each) do
    sign_in_as :regular_user
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
