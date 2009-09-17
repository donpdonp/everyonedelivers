require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :username => "testuser"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  it "should clock in a user" do
    user = User.create!(@valid_attributes)
    user.clock_in!
    user.should be_clocked_in
  end

  it "should clock out a user" do
    user = User.create!(@valid_attributes)
    user.clock_out!
    user.should_not be_clocked_in
  end

  it "should tell who can edit this user" do
    user = User.create!(@valid_attributes)
    user.available_for_edit_by(nil).should be_false
    user.available_for_edit_by(user).should be_true
  end

  it "should find the completed deliveries for a given month" do
    user = User.create!(@valid_attributes)
    deliveries = user.accepted_deliveries(2009,10)
  end
end
