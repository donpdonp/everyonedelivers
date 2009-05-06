class User < ActiveRecord::Base
  has_many :openidentities, :dependent => :destroy

  def apply_form_attributes(params)
    return if params.nil?

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
end
