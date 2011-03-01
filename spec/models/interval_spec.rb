require 'spec_helper'

describe Interval do
	describe "when searched" do
		before(:each) do
			testIntervals = [
				{
					:camera_angle => "aaa",
					:phrase_name => "pb",
					:session_type => "tt",
				},
				{
					:camera_angle => "aa",
					:phrase_name => "pc",
					:session_type => "tt",
				},
				{
					:camera_angle => "a",
					:phrase_name => "pc",
					:session_type => "ty",
				},
			]
			testIntervals.each { | properties |
				Interval.new(properties).save()
			}
		end
		it "returns substring matches for searches" do
			result = Interval.search(:query => "a")
			result.length.should == 3
		end
		it "returns exact matches for filters" do
			result = Interval.search(:camera_angle => "a")
			result.length.should == 1
		end
		it "returns the intersection of two filters" do
			result = Interval.search(:session_type => "tt", :phrase_name=>"pc")
			result.length.should == 1
		end
		it "returns the intersection of a filter and a search" do
			result = Interval.search(:query => "aa", :phrase_name => "pc")
			result.length.should == 1
		end
		it "returns nothing when appropriate" do
			result = Interval.search(:query => "akjlnsdlfknasldfkjnalsdjkfnalsdjf")
			result.length.should == 0
		end
		it "returns everything when given no search parameters" do
			result = Interval.search({})
			everything = Interval.all()
			result.should == everything
		end
	end
	context "accessor functions" do
		before(:each) do
			@interval = Interval.new(
				:start_time => DateTime.parse("May 3 1988 4:55 AM PST"),
				:duration => 12060
			)
		end
		describe "duration_string" do
			it "returns a HHhMMm string" do
				@interval.duration_string.should == "03h21m"
			end
		end
		describe "day" do
			it "returns a stringy day" do
				@interval.day.should == "05-03-88"
			end
		end
		describe "start_time_of_day" do
			it "returns a stringy time of day" do
				@interval.start_time_of_day.should == " 4:55 AM"
			end
		end
		describe "end_time" do
			it "returns the end time of the interval as a Time" do
				end_time = @interval.end_time
				end_time.class.should == Time
				end_time.should == Time.parse("May 3 1988 8:16 AM PST")
			end
		end
	end
end
