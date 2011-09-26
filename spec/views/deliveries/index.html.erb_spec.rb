require 'spec_helper'

describe "/deliveries/index.html.erb" do
  before(:each) do
  end

  it "should render when someone is logged in" do
    view.should_receive(:user_signed_in?).twice.and_return(true)
    user = mock_model(User)
    assign(:clocked_ins,[user])
    user.should_receive(:clocked_in?).and_return(false)
    user.should_receive(:username).and_return("bob")
    assign(:delivery_groups, [])
    view.should_receive(:current_user).twice.and_return(user)
    render
    rendered.should have_selector('p')
  end

end
