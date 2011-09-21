require 'uuidtools'
class DeviseUser < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    User.all.each{|u| u.update_attribute :authentication_token, UUIDTools::UUID.random_create.to_s}
  end
end
