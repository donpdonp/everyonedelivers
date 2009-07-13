require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/deliveries/show" do
  
  it "should render a delivery with missing information" do
    # Setup an empty delivery
    delivery = mock_model(Delivery)
    delivery.should_receive(:created_at).and_return(Time.now)
    user = mock_model(User)
    user.should_receive(:username).and_return("Bob")
    delivery.should_receive(:listing_user).and_return(user)
    delivery.should_receive(:package)
    delivery.should_receive(:start_location)
    delivery.should_receive(:end_location)
    delivery.should_receive(:fee)
    delivery.should_receive(:delivering_user)
    assigns[:delivery] = delivery

    render '/deliveries/show'
  end
end
