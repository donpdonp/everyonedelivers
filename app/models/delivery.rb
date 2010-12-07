class Delivery < ActiveRecord::Base
  belongs_to :fee
  belongs_to :package
  belongs_to :start_location, :class_name => "Location"
  belongs_to :end_location, :class_name => "Location"
  belongs_to :listing_user, :class_name => "User"
  belongs_to :delivering_user, :class_name => "User"

  after_create :journal_on_create
  after_destroy :journal_on_destroy
  after_save :email_alert

  def email_alert
    if ok_to_display?
      Journal.create({:delivery => self, :user => listing_user, :note => "emailed delivery update letter"})
      email_notify_users
    end
  end

  def apply_form_attributes(params)
    return if params.nil?
    self.start_end_distance = params[:start_end_distance].to_i
  end

  def ok_to_display?
    !!(fee && fee.ok_to_display? && package && package.ok_to_display? && start_location && start_location.ok_to_display? && end_location && end_location.ok_to_display? && listing_user)
  end

  def overdue?(time = Time.now)
    if fee
      fee.delivery_due < time
    else
      true
    end
  end

  def delivered?
    !!delivering_user
  end

  def available_for_delivery_by(user)
    user && user != listing_user && delivering_user.nil? && !overdue? && !featured
  end

  def available_for_edit_by(user)
    user && user == listing_user
  end

  def journal_on_create
    Journal.create({:delivery => self, :user => self.listing_user, :note => "Creating Delivery"})
  end

  def journal_on_destroy
    Journal.create({:delivery => self, :user => self.listing_user, :note => "Destroyed Delivery"})
  end

  def deliverer(user)
    self.delivering_user = user
    self.accepted_at = Time.now
    Journal.create({:delivery => self, :user => user, :note => "Accepted delivery."})
  end

  def email_notify_users
    User.all(:conditions => {:email_on_new_listing => true}).each do |user|
      Mailer.deliver_delivery_updated(self, user)
    end
  end

  def display_retail_plus_package_fee
    "%0.2f" % ((self.package.price_in_cents + self.fee.price_in_cents) / 100.0)
  end

  def listing_fee_in_cents
    if self.fee.price_in_cents >= 300
      0.50
    else
      0.0
    end
  end

  def display_listing_fee
    "%0.2f" % (listing_fee_in_cents/100.0)
  end

  def self.find_at_most_hours_old(hours, time=Time.zone.now)
    start = hours.hours.ago(time)
    stop = time
    find_between_times(start,stop)
  end

  def self.find_more_than_hours_old(hours, time=Time.zone.now)
    start = Time.zone.at(0)
    stop = hours.hours.ago(time)
    find_between_times(start,stop)
  end

  def self.find_between_hours_old(smaller, larger, time=Time.zone.now)
      start = larger.hours.ago(time)
      stop = smaller.hours.ago(time)
    find_between_times(start,stop)
  end

  private
  def self.find_between_times(start,stop)
    all(:conditions => ["created_at >= ? and created_at < ?", start, stop], :order => "created_at desc, delivering_user_id asc")
  end
end
