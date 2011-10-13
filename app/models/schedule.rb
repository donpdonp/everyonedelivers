class Schedule < ActiveRecord::Base
  belongs_to :user

  def apply_form_fields(params)
    if params[:street1]
      self.street1 = params[:street1]
    end
    if params[:street2]
      self.street2 = params[:street2]
    end

    # default
    self.starting_at = Time.now

    if params["ending_at(1i)"]
      self.ending_at = Time.parse("#{params["ending_at(1i)"]}-#{params["ending_at(2i)"]}-#{params["ending_at(3i)"]} "+
                                  "#{params["ending_at(4i)"]}:#{params["ending_at(5i)"]}") 
    end

    if params[:latitude]
      self.latitude = params[:latitude]
    end
    if params[:street2]
      self.longitude = params[:longitude]
    end
  end
end
