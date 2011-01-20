require 'spec_helper'

describe "intervals/new.html.erb" do
  before(:each) do
    assign(:interval, stub_model(Interval,
      :filename => "MyString",
      :camera_angle => "MyString",
      :session_number => 1,
      :session_type => "MyString",
      :phrase_name => "MyString",
      :phrase_type => "MyString",
      :task_name => "MyString",
      :comments => "MyString"
    ).as_new_record)
  end

  it "renders new interval form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => intervals_path, :method => "post" do
      assert_select "input#interval_filename", :name => "interval[filename]"
      assert_select "input#interval_camera_angle", :name => "interval[camera_angle]"
      assert_select "input#interval_session_number", :name => "interval[session_number]"
      assert_select "input#interval_session_type", :name => "interval[session_type]"
      assert_select "input#interval_phrase_name", :name => "interval[phrase_name]"
      assert_select "input#interval_phrase_type", :name => "interval[phrase_type]"
      assert_select "input#interval_task_name", :name => "interval[task_name]"
      assert_select "input#interval_comments", :name => "interval[comments]"
    end
  end
end
