class CreateOpenids < ActiveRecord::Migration
  def self.up
    create_table :openidentities do |t|
      t.string :url
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :openidentites
  end
end