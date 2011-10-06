class Shorten
  def initialize(app)
    @app = app       
  end                

  def call(env)
    if env["HTTP_HOST"] == SETTINGS["redirect"]["hostname"]
      redir = env["SERVER_PROTOCOL"].split('/').first + "://"+ SETTINGS["email"]["domain"] +
              "/deliveries" + env["PATH_INFO"]
      status, headers, response = [ 302, {"Content-Type"=>"text/plain", "Location"=> redir }, [] ]
    else
      status, headers, response = @app.call(env)
    end
    [status, headers, response]
  end
end