# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_everyonedelivers_session',
  :secret      => 'b971ac1db8eb0be1b6f2c2e2ee0a95b32cb30f4d6cb762450c251cc1b054ec01fbd2cfd2dbfa0b2a31b902133a889126113a3919f5a630a04a0f922d7c88474a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
