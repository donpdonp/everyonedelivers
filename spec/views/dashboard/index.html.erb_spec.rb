require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dashboard/index" do
  before(:each) do
    assigns[:delivery_groups] = []
    render 'dashboard/index'
  end
  
  it "should render" do
    response.should have_tag('p')
  end
end
