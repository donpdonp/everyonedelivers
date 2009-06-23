require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GitHubController do

  #Delete these examples and add some real ones
  it "should use GitHubController" do
    controller.should be_an_instance_of(GitHubController)
  end


  describe "GET 'commit'" do
    it "should be successful" do
      get 'commit'
      response.should be_success
    end
  end
end
