ActionMailer::Base.smtp_settings = {:domain => SETTINGS["email"]["domain"]}
ActionMailer::Base.default_url_options[:host] = SETTINGS["email"]["domain"]
