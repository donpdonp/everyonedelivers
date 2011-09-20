class AddAcceptedAtToDelivery < ActiveRecord::Migration
  def self.up
   add_column :deliveries, :accepted_at, :datetime
  end

  def self.down
   remove_column :deliveries, :accepted_at
  end
end
