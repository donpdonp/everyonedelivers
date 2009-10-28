require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/dashboard/index" do
  before(:each) do
  end
  
  it "should render" do
    render 'dashboard/index'
    response.should have_tag('p')
  end
end
