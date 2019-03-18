dir = File.expand_path(__dir__)
$LOAD_PATH.unshift(dir)

require 'psych'
require 'set'
require 'grocery_config'
require 'grocery_prompt'
require 'exercise_runner'

config_path = ARGV.first || File.join(dir, 'grocery_config.yml')

ExerciseRunner.run!(config_path: config_path)
