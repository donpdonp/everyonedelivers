class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :delivery_id
      t.integer :user_id
      t.string :text

      t.timestamps
    end
  end
end
