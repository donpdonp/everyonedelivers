class DeliveryMailer < ActionMailer::Base
  default from: SETTINGS["email"]["from"]
  
  def updated(delivery, user)
    @delivery = delivery
    mail(:to => user.email, :subject => "Delivery ##{delivery.id} details updated.")
  end

  def accepted(delivery)
    @delivery = delivery
    mail(:to => delivery.listing_user.email, :subject => "Delivery ##{delivery.id} accepted for delivery.")
  end
end
