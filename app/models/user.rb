class User < ActiveRecord::Base
  has_many :openidentities, :dependent => :destroy
  has_many :sightings
  has_many :locations, :through => :sightings
  validates_presence_of :username
  validates_uniqueness_of :username

  after_create :journal_on_create

  named_scope :clocked_ins, :conditions => "clocked_in is not null"

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
  end
end
