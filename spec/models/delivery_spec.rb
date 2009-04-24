require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Delivery do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Delivery.create!(@valid_attributes)
  end

  it "should sanitize and store new attributes" do
    delivery = Delivery.create!(@valid_attributes)
    new_attributes = { :display_price => "1.50" }
    delivery.apply_form_attributes(new_attributes)
    delivery.fee.should_not be_nil
    delivery.fee.price_in_cents.should == 150
  end
end
