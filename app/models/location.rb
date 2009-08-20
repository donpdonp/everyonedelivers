class Location < ActiveRecord::Base
  has_many :deliveries
  has_many :sightings
  has_many :users, :through => :sightings

  def apply_form_attributes(params)
    return if params.nil?

    self.street = params[:address] #todo: google geocode the address
    self.latitude = params[:latitude]
    self.longitude = params[:longitude]
    self.accuracy = params[:accuracy]
  end

  def geocode!
    
  end

end
