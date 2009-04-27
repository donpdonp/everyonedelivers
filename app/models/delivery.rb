class Delivery < ActiveRecord::Base
  belongs_to :fee
  belongs_to :package
  belongs_to :start_location, :class_name => "Location"
  belongs_to :end_location, :class_name => "Location"
  belongs_to :listing_user, :class_name => "User"
  belongs_to :delivery_user, :class_name => "User"

  def apply_form_attributes(params)
    return if params.nil?
  end

  def ok_to_display?
    fee && package
  end
end
