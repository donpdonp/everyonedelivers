require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do

  before(:each) do 
    controller.stub!(:set_timezone)
  end

  it "should display details for a user" do
    user = mock_model(User)
    User.should_receive(:find_by_username).with(user.id.to_s).and_return(user)
    Delivery.should_receive(:all).with({:conditions => {:listing_user_id => user.id}, :order=>"created_at desc, delivering_user_id asc"}).and_return([])
    Delivery.should_receive(:all).with({:conditions => {:delivering_user_id => user.id}, :order=>"created_at desc, delivering_user_id asc"}).and_return([])
    get :show, {:id => user.id}
  end
end
