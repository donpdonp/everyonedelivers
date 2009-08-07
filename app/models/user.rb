class User < ActiveRecord::Base
  has_many :openidentities, :dependent => :destroy
  validates_presence_of :username
  validates_uniqueness_of :username

  after_create :journal_on_create

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

  def openid
    self.openidentities.first
  end

  def journal_on_create
    Journal.create({:delivery => nil, :user => self, :note => "New User"})
  end
end
