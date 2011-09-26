require 'spec_helper'

describe "/layouts/application.html.erb" do
  before(:each) do
    controller.should_receive(:user_signed_in?).and_return(false)
    render
  end
  
  it "should contain the google adsense code and unique ID" do
    rendered.should have_selector('div#google_adsense', :content => "getTracker\(\"#{SETTINGS["google"]["adsense"]["id"]}\"\)")
  end
end
