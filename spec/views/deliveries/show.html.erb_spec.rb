require 'spec_helper'

describe "/deliveries/show.html.erb" do
  
  it "should render a delivery in the building state" do
    # Setup an empty delivery
    delivery = mock_model(Delivery)
    delivery.should_receive(:created_at).and_return(Time.now)
    delivery.should_receive(:listing_user)
    delivery.should_receive(:package).twice
    delivery.should_receive(:start_location)
    delivery.should_receive(:start_location)
    delivery.should_receive(:start_location)
    delivery.should_receive(:end_location)
    delivery.should_receive(:fee)
    delivery.should_receive(:delivering_user)
    delivery.should_receive(:available_for_edit_by)
    delivery.should_receive(:start_end_distance)
    delivery.should_receive(:waiting?).and_return(false)
    assigns[:delivery] = delivery

    render '/deliveries/show'
  end

  it "should render a delivery with waiting state" do
    current_user = mock_model(User)
    template.should_receive(:current_user).twice.and_return(current_user)
    # Setup an empty delivery
    delivery = mock_model(Delivery)
    delivery.should_receive(:created_at).and_return(Time.now)
    user = mock_model(User)
    user.should_receive(:username).and_return("Bob")
    delivery.should_receive(:listing_user).twice.and_return(user)
    delivery.should_receive(:package).twice
    delivery.should_receive(:start_location)
    delivery.should_receive(:start_location)
    delivery.should_receive(:start_location)
    delivery.should_receive(:end_location)
    delivery.should_receive(:fee)
    delivery.should_receive(:delivering_user)
    delivery.should_receive(:start_end_distance)
    delivery.should_receive(:available_for_delivery_by).with(current_user).and_return(false)
    delivery.should_receive(:available_for_edit_by).with(current_user).and_return(false)
    delivery.should_receive(:waiting?).and_return(true)
    assigns[:delivery] = delivery

    render '/deliveries/show'
  end
end
