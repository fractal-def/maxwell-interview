require_relative '../../models/git_hub_user'
require_relative '../lib/sample_api_response'

RSpec.describe GitHubUser do
  it 'correctly generates the commit scores based on the scoring system' do
    dhh = GitHubUser.new('DHH')
    sample_api_response = JSON.parse(SAMPLE_API_RESPONSE)
    dhh.generate_score(sample_api_response)
    expect{ dhh.print_score }.to output(/DHH's github score is 121/).to_stdout
  end
end