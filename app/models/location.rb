class Location < ActiveRecord::Base
  has_many :deliveries

  def apply_form_attributes(params)
    return if params.nil?

    self.street = params[:address] #todo: google geocode the address
  end

end
