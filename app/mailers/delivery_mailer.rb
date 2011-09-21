class DeliveryMailer < ActionMailer::Base
  default from: SETTINGS["email"]["from"]
  
  def updated(delivery, user)
    @delivery = delivery
    mail(:to => user.email, :subject => "Delivery ##{delivery.id} updated")
  end
end
