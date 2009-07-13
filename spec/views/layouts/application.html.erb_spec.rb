require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "View layout: Application" do
  before(:each) do
    render 'layouts/application'
  end
  
  it "should render" do
    response.should have_tag('div#google_adsense', /getTracker\("#{SETTINGS["google"]["adsense"]["id"]}"\)/)
  end
end
