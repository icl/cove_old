require 'spec_helper'

describe Admin::UsersController do
  describe "GET 'index'" do
    before(:each) do
      sign_in Factory(:admin_user)
      get 'index'
    end
    it {should respond_with(:success)}
    it {should render_template(:index)}
  end
end
