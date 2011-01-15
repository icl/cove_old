require 'spec_helper'

describe NdaController do
  describe "GET 'index'" do
    before(:each) do
      get :index
    end  
    it {should respond_with(:success)}
    it {should render_template("index")}
  end
end
