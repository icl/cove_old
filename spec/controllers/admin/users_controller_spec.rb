require 'spec_helper'

describe Admin::UsersController do
  before(:each) {sign_in Factory(:admin_user)}
  describe "GET 'index'" do
    before(:each) {get 'index'}
    it {should respond_with(:success)}
    it {should render_template(:index)}
  end
  
  describe "GET 'new'" do
    before(:each){get 'new'}
    it {should render_template(:new)}
    it {should respond_with(:success)}
  end
end
