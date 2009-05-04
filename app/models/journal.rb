class Journal < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :user
  belongs_to :package
  belongs_to :location

  after_create :queue_an_email

  def queue_an_email
    EMAIL_QUEUE.publish({:to => SETTINGS["journal"]["notification_email_address"]}.to_yaml)
  end
end
