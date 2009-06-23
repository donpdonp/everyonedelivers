class GitHubController < ApplicationController
  def commit
    cmd = RAILS_ROOT+"/github-pull.sh"
    logger.info("github commit: #{cmd}")
    system(cmd)
  end

end
