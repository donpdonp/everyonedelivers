require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DashboardController do

  before(:each) do
    controller.stub!(:set_timezone)
  end

  it "should display the splash page when logged out" do
    get :index
    response.should render_template("dashboard/splash.html.erb")
  end

  it "should display the dashboard when logged in" do
    @user = mock_model(User)
    controller.stub!(:current_user).and_return(@user)

    Delivery.should_receive(:find_at_most_hours_old).and_return([])
    get :index
    response.should render_template("dashboard/index.html.erb")
  end

end
