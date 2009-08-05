require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe JournalController do

  before(:each) do
    controller.stub!(:set_timezone)
  end

  it "should show the journal" do
    get :index
  end

end
