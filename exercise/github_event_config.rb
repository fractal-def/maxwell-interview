# frozen_string_literal: true

class GithubEventConfig
  attr_reader :default_points, :points

  def initialize(point_map)
    raise ArgumentError, 'Missing `Default` key' unless point_map.key?('Default')

    @points = point_map
    @default_points = point_map['Default']
  end

  def [](event_type)
    points.fetch(event_type, default_points)
  end
end
