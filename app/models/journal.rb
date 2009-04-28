class Journal < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :user
  belongs_to :package
  belongs_to :location

end
