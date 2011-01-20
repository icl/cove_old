require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    before(:each) do
      get :index
    end
    it {should respond_with(:success)}
  end

end
