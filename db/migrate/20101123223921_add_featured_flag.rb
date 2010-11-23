class AddFeaturedFlag < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :featured, :boolean
  end

  def self.down
    remove_column :deliveries, :featured
  end
end
