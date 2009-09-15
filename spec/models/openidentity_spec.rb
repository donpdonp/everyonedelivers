require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Openidentity do
  before(:each) do
    @valid_attributes = {
      :url => "http://bob",
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Openidentity.create!(@valid_attributes)
  end

  it "should make a sane-looking username from an openid url" do
    google_openid = "https://www.google.com/accounts/o8/id?id=AItOawmpw0riwUzLvLg9u7MnDLlRqn8BR60TyPU"
    google_username = "google-AI60TyPU"
    Openidentity.generate_username(google_openid).should == google_username
  end
end
