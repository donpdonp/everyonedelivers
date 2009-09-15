class Mailer < ActionMailer::Base
   def signup_notification(recipient)
     recipients recipient.email
     from       "Everyone Delivers <system@#{SETTINGS["email"]["domain"]}>"
     subject    "Signup Successful"
     body       :user => recipient
   end

   def delivery_accepted(delivery)
     recipients delivery.listing_user.email
     from       "Everyone Delivers <system@#{SETTINGS["email"]["domain"]}>"
     subject    "Delivery ##{delivery.id} has been accepted by #{delivery.delivering_user.username}"
     body       :delivery => delivery
   end
end
