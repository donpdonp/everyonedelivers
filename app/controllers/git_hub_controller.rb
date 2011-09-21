class GitHubController < ApplicationController
  protect_from_forgery :except => :commit

# Example github post
#Processing ApplicationController#commit (for ::ffff:65.74.177.129 at 2009-06-23 06:03:24) [POST]
#Parameters: {"payload"=>"{\"after\": \"801db8c488a37ff9a888a6fc1b5a5fca5290aeab\", \"ref\": \"refs/heads/master\", \"repository\": {\"owner\": {\"name\": \"donpdonp\", \"email\": \"don.park@gmail.com\"}, \"description\": \"crowdsourced services market\", \"forks\": 0, \"name\": \"everyonedelivers\", \"private\": false, \"url\": \"http://github.com/donpdonp/everyonedelivers\", \"fork\": false, \"watchers\": 1, \"homepage\": \"http://everyonedelivers.com\"}, \"before\": \"c4794c51b48bbf72951a8229556365fa67e1bbed\", \"commits\": [{\"modified\": [\"app/controllers/git_hub_controller.rb\"], \"added\": [], \"url\": \"http://github.com/donpdonp/everyonedelivers/commit/801db8c488a37ff9a888a6fc1b5a5fca5290aeab\", \"timestamp\": \"2009-06-22T23:03:14-07:00\", \"message\": \"always test.\", \"removed\": [], \"author\": {\"name\": \"Don Park\", \"email\": \"don@donpark.org\"}, \"id\": \"801db8c488a37ff9a888a6fc1b5a5fca5290aeab\"}]}"}
  def commit
    gparams = JSON.parse(params["payload"])
    logger.info("github params: #{gparams}")
    cmd = Rails.root+"github-pull.sh"
    logger.info("github commit: #{cmd}")
    out = `/bin/sh #{cmd}`
    logger.info("github pull output: #{out}")
    Journal.create({:note => "Website code updated to #{gparams["after"]}"})
    render :nothing => true
  end

  # so we can mock this in a test
  def shell(cmd)
    `/bin/sh #{cmd}`
  end

end
