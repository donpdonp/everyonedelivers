require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Fee do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Fee.create!(@valid_attributes)
  end

  it "should sanitize and store new attributes" do
    fee = Fee.create!(@valid_attributes)
    new_attributes = { :display_price => "1.50" }
    fee.apply_form_attributes(new_attributes)
    fee.price_in_cents.should == 150
  end
end
