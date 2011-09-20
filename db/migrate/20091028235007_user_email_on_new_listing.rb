class UserEmailOnNewListing < ActiveRecord::Migration
  def self.up
    add_column :users, :email_on_new_listing, :boolean
  end

  def self.down
    remove_column :users, :email_on_new_listing
  end
end
