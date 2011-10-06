# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111006165028) do

  create_table "comments", :force => true do |t|
    t.integer  "delivery_id"
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "deliveries", :force => true do |t|
    t.integer  "fee_id"
    t.integer  "package_id"
    t.integer  "start_location_id"
    t.integer  "end_location_id"
    t.integer  "listing_user_id"
    t.integer  "delivering_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start_end_distance"
    t.datetime "accepted_at"
    t.boolean  "featured"
    t.string   "workflow_state"
  end

  create_table "fees", :force => true do |t|
    t.integer  "price_in_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "delivery_due"
    t.string   "payment_method"
  end

  create_table "journal", :force => true do |t|
    t.integer  "delivery_id"
    t.integer  "package_id"
    t.integer  "user_id"
    t.integer  "location_id"
    t.float    "fee"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "street"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "accuracy"
    t.string   "name"
  end

  create_table "open_id_associations", :force => true do |t|
    t.binary  "server_url", :null => false
    t.string  "handle",     :null => false
    t.binary  "secret",     :null => false
    t.integer "issued",     :null => false
    t.integer "lifetime",   :null => false
    t.string  "assoc_type", :null => false
  end

  create_table "open_id_nonces", :force => true do |t|
    t.string  "server_url", :null => false
    t.integer "timestamp",  :null => false
    t.string  "salt",       :null => false
  end

  create_table "openidentities", :force => true do |t|
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", :force => true do |t|
    t.string   "description"
    t.float    "weight_in_grams"
    t.float    "height_in_meters"
    t.float    "width_in_meters"
    t.float    "depth_in_meters"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_in_cents"
  end

  create_table "sightings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.string   "display_measurement"
    t.string   "email"
    t.datetime "clocked_in"
    t.boolean  "email_on_new_listing"
    t.string   "authentication_token"
  end

end
