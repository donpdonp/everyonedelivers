module OpenidUtility
  def consumer
    store = ActiveRecordStore.new
    OpenID::Consumer.new(session, store)
  end

  def email_to_openid_filter(email)
    case email
      when /@gmail.com$/
        "https://www.google.com/accounts/o8/id"
      when /(.*)@aol.com$/
        "http://openid.aol.com/#{$1}"
      else
        email
    end
  end
end
