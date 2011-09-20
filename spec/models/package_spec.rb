require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Package do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Package.create!(@valid_attributes)
  end

  it "should sanitize and store new attributes" do
    package = Package.create!(@valid_attributes)
    description="desc"
    form_attributes = { :description => description, :height => "3.30" }
    package.apply_form_attributes(form_attributes)
    package.description.should == description
    package.height_in_meters.should > 0.08 #fix
    package.height_in_meters.should < 0.09 #fix
  end
end
