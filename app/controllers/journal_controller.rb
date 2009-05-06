class JournalController < ApplicationController

  def index
    @entries = Journal.all(:order => "id desc")
  end
end
