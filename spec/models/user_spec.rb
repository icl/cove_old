require 'spec_helper'


describe User do
  context "validation" do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:admin)}
  end
end
