class GithubEventFeed
  extend GithubAPIHelper

  def self.get(username)
    http_get("/users/#{username}/events/public")
  end
end
