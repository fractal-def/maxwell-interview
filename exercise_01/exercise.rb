require_relative 'models/git_hub_user'

dhh = GitHubUser.new('DHH')
dhh.fetch_commits
dhh.generate_score
dhh.print_score