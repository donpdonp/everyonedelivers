class AddUsersClockedIn < ActiveRecord::Migration
  def self.up
    add_column :users, :clocked_in, :boolean
  end

  def self.down
    remove_column :users, :clocked_in
  end
end
