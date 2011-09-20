require 'spec_helper'

describe "/layouts/application.html.erb" do
  before(:each) do
    render
  end
  
  it "should contain the google adsense code and unique ID" do
    response.should have_tag('div#google_adsense', /getTracker\("#{SETTINGS["google"]["adsense"]["id"]}"\)/)
  end
end
