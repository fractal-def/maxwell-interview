class GithubEventConfig
  attr_reader :points
  
  def initialize(point_map)
    @points = point_map
  end
end
