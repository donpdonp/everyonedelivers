require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DashboardController do

  before(:each) do
    controller.stub!(:set_timezone)
  end

  it "should display the splash" do
    get :index
    response.should render_template("dashboard/index.html.erb")
  end

end
