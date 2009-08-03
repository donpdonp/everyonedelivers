class AddTimeToFee < ActiveRecord::Migration
  def self.up
    add_column :fees, :delivery_due, :datetime
    Fee.reset_column_information
    Delivery.all.each{|d| d.fee.update_attribute(:delivery_due, d.created_at) if d.fee}
    Fee.all(:conditions => {:delivery_due => nil}).each{|f| f.update_attribute :delivery_due, Time.now}
  end

  def self.down
    remove_column :fees, :delivery_due
  end
end
