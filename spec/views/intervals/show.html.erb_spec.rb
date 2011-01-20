require 'spec_helper'

describe "intervals/show.html.erb" do
  before(:each) do
    @interval = assign(:interval, stub_model(Interval,
      :filename => "Filename",
      :camera_angle => "Camera Angle",
      :session_number => 1,
      :session_type => "Session Type",
      :phrase_name => "Phrase Name",
      :phrase_type => "Phrase Type",
      :task_name => "Task Name",
      :comments => "Comments"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Filename/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Camera Angle/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Session Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phrase Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phrase Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Task Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Comments/)
  end
end
