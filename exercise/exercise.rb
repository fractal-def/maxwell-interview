dir = File.expand_path(__dir__)
$LOAD_PATH.unshift(dir)
require 'psych'
require 'github_event_score'

config_file = File.join(dir, 'event_points.yml')

username     = ARGV.first || 'DHH'
point_config = Psych.load(File.read(config_file))

GithubEventScore.run!(username, point_config)
