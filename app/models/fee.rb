class Fee < ActiveRecord::Base
  has_many :deliveries

  def apply_form_attributes(params)
    return if params.nil?

    if params[:display_price]
      self.price_in_cents = (params[:display_price].to_f*100).to_i
    end

    if params["delivery_due(1i)"]
      time_string = "#{params["delivery_due(1i)"]}-#{params["delivery_due(2i)"]}-#{params["delivery_due(3i)"]} #{params["delivery_due(4i)"]}:#{params["delivery_due(5i)"]}"
      delivery_due_time = Time.zone.parse(time_string)
      self.delivery_due = delivery_due_time
    end

    if params[:payment_method]
      self.payment_method = params[:payment_method]
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

  def ok_to_display?
    true
  end
end
