class UserAddTimezoneDisplaymeasurement < ActiveRecord::Migration
  def self.up
    add_column :users, :time_zone, :string
    add_column :users, :display_measurement, :string
  end

  def self.down
    remove_column :users, :time_zone
    remove_column :users, :display_measurement
  end
end
