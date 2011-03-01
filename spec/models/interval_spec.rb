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
	end
end
