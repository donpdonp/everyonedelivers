class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :description
      t.integer :weight_in_grams
      t.integer :height_in_meters
      t.integer :width_in_meters
      t.integer :depth_in_meters
      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end
