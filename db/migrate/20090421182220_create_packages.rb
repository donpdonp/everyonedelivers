class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :description
      t.float :weight_in_grams
      t.float :height_in_meters
      t.float :width_in_meters
      t.float :depth_in_meters
      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end
