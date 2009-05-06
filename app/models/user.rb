class User < ActiveRecord::Base
  has_many :openidentities

  def apply_form_attributes(params)
    return if params.nil?

    if params[:username]
      self.username = params[:username]
    end
  end

  def openid
    self.openidentities.first
  end
end
