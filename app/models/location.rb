class Location < ActiveRecord::Base
  has_many :deliveries
end
