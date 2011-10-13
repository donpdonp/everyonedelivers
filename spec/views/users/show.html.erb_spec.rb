require 'spec_helper'

describe "/users/show.html.erb" do
  before(:each) do
    view.stub!(:user_signed_in?).and_return(true)
    @user = mock_model(User, :username => "bob")
  end
  
  it "should render" do
    assign(:user, @user)
    render
    rendered.should have_selector('div#sampledelivery')
  end
end
