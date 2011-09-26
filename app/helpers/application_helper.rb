module ApplicationHelper
  def link_to_user(user)
    if user
      link_to user.username
    else
      "(none)"
    end
  end
end
