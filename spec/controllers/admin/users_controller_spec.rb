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
  
  describe "POST 'create'" do
    context "admin submits a file" do
      before(:each) do
        @test_file = mock()
        @test_file.expects(:read).returns('blah@test.com, foo@bar.com, who@what.com')
        @old_count = User.count
        post :create, :user => {:email_list => @test_file}
      end
      it {should redirect_to(:action => "new")}
      it "should add users to the db" do
        User.count().should == @old_count + 3
      end
    end
    
    context "admin fill is the text box" do
      before(:each) do
        post :create, :user => {:email => "new@invite.com"}
        @old_count = User.count
      end
      it {should redirect_to(:action => "new")}
      it "should add user to the db" do
        User.where(:email => "new@invite.com").first().should be
      end
    end
    
  end
end
