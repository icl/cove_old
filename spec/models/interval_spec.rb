require 'spec_helper'

describe Interval do
	describe "when searched" do
		before(:each) do
			testIntervals = [
				{
					:camera_angle => "aaa",
				},
				{
					:camera_angle => "aa",
				},
				{
					:camera_angle => "a",
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
	end
end
