class Delivery < ActiveRecord::Base
  belongs_to :fee
  belongs_to :package
  belongs_to :start_location, :class_name => "Location"
  belongs_to :end_location, :class_name => "Location"
  belongs_to :listing_user, :class_name => "User"
  belongs_to :delivery_user, :class_name => "User"

  def apply_form_attributes(params)
    return if params.nil?

    #sanitize and store
    if params[:display_price]
      price = (params[:display_price].to_f*100).to_i
      self.fee = Fee.create(:price_in_cents => price)
    end
  end

  # display helper (at the model level for the form builder)
  def display_price
    "%0.2f" % price
  end

  def price
    if self.fee
      self.fee.price_in_cents / 100.0
    else
      0.0
    end
  end
end
