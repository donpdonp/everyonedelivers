class CreateJournal < ActiveRecord::Migration
  def self.up
    create_table :journal do |t|
      t.integer delivery_id
      t.integer package_id
      t.integer user_id
      t.integer location_id
      t.float fee
      t.timestamps
    end
  end

  def self.down
    drop_table :journal
  end
end
