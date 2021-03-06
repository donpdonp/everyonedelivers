class Location < ActiveRecord::Base
  has_many :deliveries
  has_many :sightings
  has_many :users, :through => :sightings

  def apply_form_attributes(params)
    return if params.nil?
    self.name = params[:name]
    self.street = params[:address] #todo: google geocode the address
    self.latitude = params[:latitude]
    self.longitude = params[:longitude]
    self.accuracy = params[:accuracy]
  end

  def ok_to_display?
    street && street.size > 0
  end

  def geocode!
    
  end

  def gmap_static_html(h,w,z)
  "http://dev.virtualearth.net/REST/v1/Imagery/Map/Road/?mapSize=#{h},#{w}&pushpin=#{self.latitude},#{self.longitude};33&key=#{SETTINGS["bing"]["maps"]["key"]}"
#    "http://maps.google.com/staticmap?center=#{self.latitude},#{self.longitude}&zoom=#{z}&size=#{h}x#{w}&key=#{SETTINGS["google"]["maps"]["key"]}&sensor=false&markers=#{self.latitude},#{self.longitude}"
#   "http://staticmap.openstreetmap.de/staticmap.php?center=#{self.latitude},#{self.longitude}&zoom=#{z}&size=#{h}x#{w}&markers=#{self.latitude},#{self.longitude}"
  end

  def street_parts
    parts = street.split(',',street.count(','))
  end
end
