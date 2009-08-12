class Mailer < ActionMailer::Base
   def signup_notification(recipient)
     recipients recipient.email
     from       "system@everyonedelivers.com"
     subject    "Signup Successful"
     body       :user => recipient
   end
end
