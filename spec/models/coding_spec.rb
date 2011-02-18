require 'spec_helper'

describe Coding do
  describe "validation" do
    it {should validate_presence_of(:user_id)}
    it {should validate_presence_of(:interval_id)}
    it {should validate_presence_of(:code_id)}
  end
end
