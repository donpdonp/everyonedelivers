class AddTimeToFee < ActiveRecord::Migration
  def self.up
    add_column :fees, :delivery_due, :datetime
  end

  def self.down
    remove_column :fees, :delivery_due
  end
end
