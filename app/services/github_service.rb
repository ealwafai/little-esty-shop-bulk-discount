class GithubService
  def self.repo_info
    response = Faraday.get("https://api.github.com/repos/InOmn1aParatus/little-esty-shop")
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.contributor_info
    response = Faraday.get("https://api.github.com/repos/InOmn1aParatus/little-esty-shop/contributors")
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.pulls_info
    response = Faraday.get("https://api.github.com/repos/InOmn1aParatus/little-esty-shop/pulls?state=closed")
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end
