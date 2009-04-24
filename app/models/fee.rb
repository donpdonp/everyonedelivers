class Fee < ActiveRecord::Base
  has_many :deliveries

  def apply_form_attributes(params)
    return if params.nil?

    if params[:display_price]
      self.price_in_cents = (params[:display_price].to_f*100).to_i
    end
  end

  def display_price
    "%0.2f" % float_price
  end

  def float_price
    if self.price_in_cents
      self.price_in_cents / 100.0
    else
      0.0
    end
  end
end
