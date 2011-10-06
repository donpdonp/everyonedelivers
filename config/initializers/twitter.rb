Twitter.configure do |config|
  config.consumer_key = SETTINGS["twitter"]["consumer_key"]
  config.consumer_secret = SETTINGS["twitter"]["consumer_secret"]
  config.oauth_token = SETTINGS["twitter"]["oauth_token"]
  config.oauth_token_secret = SETTINGS["twitter"]["oauth_secret"]
end
