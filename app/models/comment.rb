class Comment < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :user
end
