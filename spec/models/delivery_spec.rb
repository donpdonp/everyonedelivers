require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Delivery do
  fixtures :deliveries

  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Delivery.create!(@valid_attributes)
  end

  it "should find deliveries at most X hours old" do
    time = Time.parse("2009-01-01 12:45 UTC")
    deliveries = Delivery.find_at_most_hours_old(1,time)
    deliveries.size.should == 2
    # return in time-sorted order
    deliveries.first.created_at.should > deliveries.last.created_at
  end

  it "should find deliveries between X and Y X hours old" do
    time = Time.parse("2009-01-01 12:45 UTC")
    deliveries = Delivery.find_between_hours_old(1, 2, time)
    deliveries.size.should == 2
    # return in time-sorted order
    deliveries.first.created_at.should > deliveries.last.created_at
  end

  it "should find deliveries more than X hours old" do
    time = Time.parse("2009-01-01 12:45 UTC")
    deliveries = Delivery.find_more_than_hours_old(4, time)
    deliveries.size.should == 2
    # return in time-sorted order
    deliveries.first.created_at.should > deliveries.last.created_at
  end

  it "should start with the building state" do
    delivery = Delivery.new
    delivery.building?.should be_true
  end

  it "test if the delivery data is complete" do
    delivery = Delivery.new
    delivery.should_receive(:building?).and_return(true)
    delivery.should_receive(:ok_to_display?).and_return(true)
    delivery.should_receive(:ready!).and_return(true)
    delivery.check_for_completeness
  end

  it "journal and send email when ready" do
    delivery = Delivery.new
    delivery.should_receive(:email_notify_users)
    delivery.ready!
  end

end
