class GithubPulls
  attr_reader :pull_requests

  def initialize(data)
    @pull_requests = add_pulls(data)
  end

  def add_pulls(data)
    hash = Hash.new(0)
    data.each do |pull|
      hash[pull[:user][:login]] += 1
    end
    hash
  end
end
