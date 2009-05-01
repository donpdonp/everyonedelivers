class Delivery < ActiveRecord::Base
  belongs_to :fee
  belongs_to :package
  belongs_to :start_location, :class_name => "Location"
  belongs_to :end_location, :class_name => "Location"
  belongs_to :listing_user, :class_name => "User"
  belongs_to :delivering_user, :class_name => "User"

  after_create :journal_on_create

  def apply_form_attributes(params)
    return if params.nil?
  end

  def ok_to_display?
    fee && package && start_location && end_location && listing_user
  end

  def journal_on_create
    Journal.create({:delivery => self, :note => "Created Delivery"})
    Journal.create({:delivery => self, :user => self.listing_user, :note => "Delivery Listed by"})
  end

  def deliverer(user)
    self.delivering_user = user
    Journal.create({:delivery => self, :user => user, :note => "Delivery Accepted"})
  end

  def self.find_at_most_hours_old(hours)
    all(:conditions => ["created_at >= ?", hours.hour.ago], :order => "created_at desc, delivering_user_id asc")
  end

  def self.find_more_than_hours_old(hours)
    all(:conditions => ["created_at < ?", hours.hour.ago], :order => "created_at desc, delivering_user_id asc")
  end

  def self.find_between_hours_old(start,stop)
    all(:conditions => ["created_at >= ? and created_at < ?", start.hours.ago, stop.hours.ago], :order => "created_at desc, delivering_user_id asc")
  end
end
