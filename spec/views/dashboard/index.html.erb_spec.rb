require 'spec_helper'

describe "/dashboard/index.html.erb" do
  before(:each) do
    view.stub!(:user_signed_in?).and_return(false)
  end
  
  it "should render" do
    featured_delivery = mock_model(Delivery)
    featured_delivery.should_receive(:ok_to_display?).and_return(false)
    assign(:featured_delivery,featured_delivery)
    render
    rendered.should have_selector('div#sampledelivery')
  end
end
