class GithubContributor
  attr_reader :contributors

  def initialize(data)
    @contributors = add_contributors(data)
  end

  def add_contributors(data)
    hash = {}
    data.each do |contributor|
      if [56685055, 79383963, 77654906, 81600649].include?(contributor[:id])
        hash[contributor[:login]] = contributor[:contributions]
      end
    end
    hash
  end
end
