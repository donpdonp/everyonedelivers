require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GitHubController do

  before(:each) do
    controller.stub!(:set_timezone)
  end

  describe "GET 'commit'" do
    it "should be successful" do
      get 'commit'
      response.should be_success
    end
  end
end
