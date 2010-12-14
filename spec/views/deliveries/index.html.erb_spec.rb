require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dashboard/index" do
  before(:each) do
  end

  it "should render when someone is logged in" do
    template.stub!(:logged_in?).and_return(true)
    assigns[:delivery_groups] = []
    user = mock_model(User)
    assigns[:clocked_ins] = [user]
    user.should_receive(:clocked_in?).and_return(false)
    user.should_receive(:username).and_return("bob")
    template.should_receive(:current_user).twice.and_return(user)
    render 'deliveries/index'
    response.should have_tag('p')
  end

end
