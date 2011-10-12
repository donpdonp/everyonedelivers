class User < ActiveRecord::Base
  has_many :openidentities, :dependent => :destroy
  has_many :sightings
  has_many :locations, :through => :sightings
  has_many :schedules
  validates_presence_of :username, :email, :authentication_token
  validates_uniqueness_of :username, :email

  after_create :journal_on_create

  scope :clocked_ins, :conditions => "clocked_in is not null"

  has_friendly_id :username, :use_slug => true

  devise :token_authenticatable

  def self.create_with_defaults!(attributes)
    user = User.new(attributes)
    if attributes[:username].nil?
      user.username = pick_username(user.email)
    end
    user.display_measurement = "imperial"
    user.email_on_new_listing = false
    user.authentication_token = UUIDTools::UUID.random_create.to_s
    user.save!
    user
  end

  def apply_form_attributes(params)
    return if params.nil?

    if params[:email]
      self.email = params[:email]
    end

    if params[:username]
      self.username = params[:username]
    end

    if params[:time_zone]
      self.time_zone = params[:time_zone]
    end

    if params[:display_measurement]
      self.display_measurement = params[:display_measurement]
    end

    if params[:email_on_new_listing]
      self.email_on_new_listing = params[:email_on_new_listing]
    end
  end

  def available_for_edit_by(user)
    self == user
  end

  def openid
    self.openidentities.first
  end

  def journal_on_create
    Journal.create({:delivery => nil, :user => self, :note => "New User"})
  end

  def clock_in!
    update_attribute :clocked_in, Time.now
    Journal.create({:delivery => nil, :user => self, :note => "Clocked In"})
  end

  def clock_out!
    update_attribute :clocked_in, nil
    Journal.create({:delivery => nil, :user => self, :note => "Clocked Out"})
  end

  def soft_validate
    # suggest to the user that field be filled in.
    if time_zone.blank?
      errors.add(:time_zone, "Please set a timezone")
    end
    if email.blank?
      errors.add(:email, "Please provide an email address")
    end
    if display_measurement.blank?
      errors.add(:display_measurement, "Please choose your units of measurement")
    end
  end

  def listed_deliveries
    deliveries = Delivery.all(:conditions => {:listing_user_id => self.id}, :order => "created_at desc, delivering_user_id asc")
    deliveries.select{|d| d.ok_to_display? }
  end

  def accepted_deliveries(year=nil, month=nil)
    if year && month
      mark = Time.parse("#{year}-#{month}-01")
      conditions = ["delivering_user_id = ? and accepted_at >= ? and accepted_at < ?", self.id, mark, mark.next_month ]
    else
      conditions = {:delivering_user_id => self.id}
    end
    deliveries = Delivery.all(:conditions => conditions, :order => "created_at desc, delivering_user_id asc")
    deliveries.select{|d| d.ok_to_display? }
  end

  def self.pick_username(email)
    username = email.split('@')[0]
    if User.find_by_username(username)
      logger.info("found! addin number")
      username += (rand(89999)+10000).to_s
    end
    logger.info("picked: #{username}")
    username
  end
end
