class AddUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t| 
      t.string :username
      t.timestamps
    end
  end

  def self.down
  end
end
