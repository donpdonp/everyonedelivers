require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DashboardController do

  #Delete this example and add some real ones
  it "should display the landing page" do
    Delivery.should_receive(:find_at_most_hours_old).and_return([])
    Delivery.should_receive(:find_between_hours_old).and_return([])
    Delivery.should_receive(:find_more_than_hours_old).and_return([])
    get :index
    response.should render_template("dashboard/index.html.erb")
  end

end
