class GithubService
  def self.user_info(username)
    response = Faraday.get "https://api.github.com/users/#{username}"
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end
