class User < ActiveRecord::Base
  has_many :openids

  def openid
    self.openids.first
  end
end
