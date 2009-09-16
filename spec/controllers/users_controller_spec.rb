require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do

  before(:each) do 
    controller.stub!(:set_timezone)
    @user = mock_model(User)
    controller.stub!(:current_user).and_return(@user)
  end

  it "should display details for a user" do
    user = mock_model(User)
    User.should_receive(:find_by_username).with(user.id.to_s).and_return(user)
    get :show, {:id => user.id}
  end

  it "should clock in a user" do
    User.should_receive(:find_by_username).with(@user.id.to_s).and_return(@user)
    @user.should_receive(:clock_in!)
    @user.should_receive(:username).and_return('bob')
    get :clock_in, {:id => @user.id}
    response.should redirect_to(root_url)
  end

  it "should clock out a user" do
    User.should_receive(:find_by_username).with(@user.id.to_s).and_return(@user)
    @user.should_receive(:clock_out!)
    @user.should_receive(:username).and_return('bob')
    get :clock_out, {:id => @user.id}
    response.should redirect_to(root_url)
  end
end
