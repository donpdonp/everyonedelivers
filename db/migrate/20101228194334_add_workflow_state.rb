class AddWorkflowState < ActiveRecord::Migration
  def self.up
    add_column :deliveries, :workflow_state, :string
    Delivery.all.each do |d|
      if d.delivering_user
        d.update_attribute :workflow_state, "delivered"
      else
        if d.ok_to_display?
          d.update_attribute :workflow_state, "waiting"
        else
          d.update_attribute :workflow_state, "building"
        end
      end
    end
  end

  def self.down
    remove_column :deliveries, :workflow_state
  end
end
