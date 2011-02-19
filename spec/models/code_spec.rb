require 'spec_helper'

describe Code do
  before(:each)do
    Factory(:code)
  end
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:coding_type)}
    it {should validate_uniqueness_of(:name)}
  end
end
