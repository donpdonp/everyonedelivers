class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.integer :price_in_cents
      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
