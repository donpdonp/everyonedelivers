module OpenidUtility
  def consumer
    store = ActiveRecordStore.new
    OpenID::Consumer.new(session, store)
  end
end
