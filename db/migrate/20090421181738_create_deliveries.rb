class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.integer :fee_id
      t.integer :package_id
      t.integer :start_location_id
      t.integer :end_location_id
      t.integer :listing_user_id
      t.integer :delivering_user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
