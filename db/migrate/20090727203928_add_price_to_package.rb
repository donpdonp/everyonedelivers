class AddPriceToPackage < ActiveRecord::Migration
  def self.up
    add_column :packages, :price_in_cents, :integer
  end

  def self.down
    remove_column :packages, :price_in_cents
  end
end
