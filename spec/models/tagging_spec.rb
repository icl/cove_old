require 'spec_helper'

describe Tagging do
  describe "validation" do
    it {should validate_presence_of(:tag_id)}
    it {should validate_presence_of(:user_id)}
    it {should validate_presence_of(:interval_id)}
  end
end
