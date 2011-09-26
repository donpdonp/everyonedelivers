require File.dirname(__FILE__) + '/../spec_helper'

describe SessionController do
  before(:each) do
    controller.stub!(:set_timezone)
  end

  it "logs in a first-time user" do
    token = 'abc123'
    user = mock_model(User)
    User.should_receive(:find_by_authentication_token).with(token).and_return(user)
    controller.should_receive(:sign_in)
    get :login_token, {:token => token}
  end

  it "should logout the user" do
    controller.should_receive(:reset_session)
    get :logout
  end
end
