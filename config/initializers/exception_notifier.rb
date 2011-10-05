    EveryoneDelivers::Application.config.middleware.use(ExceptionNotifier,
                        :sender_address => SETTINGS["email"]["from"],
                        :exception_recipients => SETTINGS["exception_notifier"]["email"])
