require 'spec_helper'

describe "intervals/index.html.erb" do
  before(:each) do
    assign(:intervals, [
      stub_model(Interval,
        :filename => "Filename",
        :camera_angle => "Camera Angle",
        :session_number => 1,
        :session_type => "Session Type",
        :phrase_name => "Phrase Name",
        :phrase_type => "Phrase Type",
        :task_name => "Task Name",
        :comments => "Comments"
      ),
      stub_model(Interval,
        :filename => "Filename",
        :camera_angle => "Camera Angle",
        :session_number => 1,
        :session_type => "Session Type",
        :phrase_name => "Phrase Name",
        :phrase_type => "Phrase Type",
        :task_name => "Task Name",
        :comments => "Comments"
      )
    ])
  end

  it "renders a list of intervals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Camera Angle".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Session Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phrase Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phrase Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Task Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Comments".to_s, :count => 2
  end
end
