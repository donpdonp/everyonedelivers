class Fee < ActiveRecord::Base
  has_many :deliveries
end
