class AddFeeMethod < ActiveRecord::Migration
  def self.up
    add_column :fees, :payment_method, :string
  end

  def self.down
    add_column :fees, :payment_method
  end
end
