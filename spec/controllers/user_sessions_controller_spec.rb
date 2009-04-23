require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do

  it "should login" do
    id = "http://bob"
    controller.should_receive(:require_no_user)

    session = mock(UserSession)
    session.should_receive(:save).and_return(true)
    UserSession.should_receive(:new).with(:openid_identifier => id).and_return(session)

    get :create, {:openid_identifier => id}
  end

  it "should logout" do
    controller.should_receive(:require_user)

    session = mock(UserSession)
    session.should_receive(:destroy)
    controller.should_receive(:current_user_session).and_return(session)
    put :destroy
  end
end
