require "test_helper"
require_relative '../lib/score_card'
require_relative '../lib/http/github_users'

class ScoreCardTest < Minitest::Test
  describe 'ScoreCard' do
    let (:user) { 'dhh' }
    subject { ScoreCard.new(http: mock_http)}
    let (:mock_http) { Struct.new(:get, :body) }
    let (:http) { Http::GithubUsers }

    describe 'attributes' do
      it 'takes a user' do
        assert_equal user, subject.user
      end

      it 'gets user data' do
        assert subject.data
      end
    end

    describe 'Public API' do
      it 'score_card' do
        skip # todo mock return
        score_card = ScoreCard.new(user: user, http: http )
        assert_equal 136, score_card.score
      end
    end
  end
end