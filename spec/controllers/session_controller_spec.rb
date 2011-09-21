require File.dirname(__FILE__) + '/../spec_helper'

describe SessionController do
  before(:each) do
    controller.stub!(:set_timezone)
  end

  it "should logout the user" do
    controller.should_receive(:reset_session)
    get :logout
  end
end
