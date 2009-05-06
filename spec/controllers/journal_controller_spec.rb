require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe JournalController do

  it "should show the journal" do
    get :index
  end

end
