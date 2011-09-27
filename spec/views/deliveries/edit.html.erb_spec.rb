require 'spec_helper'

describe "/deliveries/edit.html.erb" do
  before(:each) do
    view.stub!(:user_signed_in?).and_return(false)
    view.stub!(:current_user)
  end
  
  it "renders an empty delivery edit form" do
    delivery = mock_model(Delivery, :package => nil, :fee => nil,
                                    :delivering_user => nil, 
                                    :start_location => nil,
                                    :end_location => nil)
    assign(:delivery, delivery)

    render

  end
end