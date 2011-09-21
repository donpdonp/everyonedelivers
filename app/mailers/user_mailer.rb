class UserMailer < ActionMailer::Base
  default from: SETTINGS["email"]["from"]

  def login_token_email(user)
    @user = user
    @url = "http://#{SETTINGS["email"]["domain"]}/session/login_token?token=#{user.authentication_token}"
    mail(:to => user.email, :subject => "EveryoneDelivers Login Button")
  end
end
