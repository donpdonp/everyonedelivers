class User < ActiveRecord::Base
  has_many :openidentities

  def openid
    self.openidentities.first
  end
end
