require_relative './github_score'

output_index = ARGV[0]&.start_with?('--') ? 0 : 1
username = output_index == 0 ? 'dhh' : ARGV[0] || 'dhh'
output_format = ARGV[output_index]&.gsub('--','') || 'string'
score = GitHubScore.new(username).total

case output_format
when 'json'
  puts JSON.dump({score: score, username: username})
when 'string'
  puts "#{username}'s github score is #{score}"
else
  puts "Internal Error: no output format found"
end
