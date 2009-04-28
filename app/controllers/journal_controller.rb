class JournalController < ApplicationController

  def index
    @entries = Journal.all
  end
end
