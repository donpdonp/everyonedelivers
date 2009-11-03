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
     cc         delivery.delivering_user.email
     subject    "Delivery ##{delivery.id} has been accepted by #{delivery.delivering_user.username}"
     body       :delivery => delivery
   end

   def delivery_updated(delivery, user)
     recipients user.email
     from       "Everyone Delivers <system@#{SETTINGS["email"]["domain"]}>"
     subject    "New Delivery Listing ##{delivery.id} #{delivery.package.description}"
     body       :delivery => delivery
   end
end
