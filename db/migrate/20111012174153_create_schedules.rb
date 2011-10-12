class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :starting_at
      t.datetime :ending_at
      t.float :latitude
      t.float :longitude
      t.string :nearest_intersection

      t.integer :user_id
      t.timestamps
    end
  end
end
