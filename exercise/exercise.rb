dir = File.expand_path(__dir__)
$LOAD_PATH.unshift(dir)

require 'json'
require 'net/http'
require 'psych'
require 'github_api_helper'
require 'github_event_feed'
require 'github_event_config'
require 'github_event_score'
require 'exercise_runner'

username    = ARGV[0] || 'DHH'
config_path = ARGV[1] || File.join(dir, 'event_points.yml')

ExerciseRunner.run!(username: username, config_path: config_path)
