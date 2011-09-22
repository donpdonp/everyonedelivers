require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    valid_attributes = {
      :username => "testuser",
      :email => "some@user",
      :authentication_token => "abc123"
    }
    @user = User.create!(valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @user.should be_valid
  end

  it "should clock in a user" do
    @user.clock_in!
    @user.should be_clocked_in
  end

  it "should clock out a user" do
    @user.clock_out!
    @user.should_not be_clocked_in
  end

  it "should tell who can edit this user" do
    @user.available_for_edit_by(nil).should be_false
    @user.available_for_edit_by(@user).should be_true
  end

  it "should find the completed deliveries for a given month" do
    @deliveries = @user.accepted_deliveries(2009,10)
  end
end
