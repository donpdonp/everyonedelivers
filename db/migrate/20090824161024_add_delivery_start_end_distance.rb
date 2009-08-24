class AddDeliveryStartEndDistance < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :start_end_distance, :integer
  end

  def self.down
    remove_column :deliveries, :start_end_distance
  end
end
