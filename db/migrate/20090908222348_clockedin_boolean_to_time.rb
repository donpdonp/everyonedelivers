class ClockedinBooleanToTime < ActiveRecord::Migration
  def self.up
    remove_column :users, :clocked_in
    add_column :users, :clocked_in, :datetime
  end

  def self.down
    remove_column :users, :clocked_in
    add_column :users, :clocked_in, :boolean
  end
end
