class JournalController < ApplicationController

  def index
    @entries = Journal.all(:order => "id desc", :conditions => ["created_at > ?",1.month.ago])
  end

  def count
    @entries = Journal.count(:conditions => ["note = ? and created_at > ?", 
                                             params[:note], 
                                             params[:hours].to_i.hours.ago])
    respond_to do |format|
      format.json { render :json => {:count => @entries}.to_json }
    end
  end
end
