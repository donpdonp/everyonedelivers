class CreateSightings < ActiveRecord::Migration
  def self.up
    create_table :sightings do |t|
      t.column :user_id, :integer
      t.column :location_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :sightings
  end
end
