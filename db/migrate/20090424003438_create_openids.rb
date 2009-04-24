class CreateOpenids < ActiveRecord::Migration
  def self.up
    create_table :openids do |t|
      t.string :url
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :openids
  end
end
