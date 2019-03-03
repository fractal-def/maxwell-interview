require "test_helper"

class Maxwell::ScoreCardTest < Minitest::Test
  describe 'ScoreCard' do
    let (:user) { 'dhh' }
    let (:score_card) { Maxwell::ScoreCard.new(http: mock_http)}
    let (:mock_http) { Struct.new(:get, :body) }
    let (:http) { Maxwell::Http::GithubUsers }

    describe 'attributes' do
      it 'takes a user' do
        assert_equal user, score_card.user
      end

      it 'gets user data' do
        assert score_card.data
      end
    end

    describe 'Public API' do
      it 'score_card' do
        skip # todo mock return
        score_card = Maxwell::ScoreCard.new(user: user, http: http )
        assert_equal 137, score_card.score
      end
    end

    describe 'Private methods. OKAY to delete if they break' do

      it '#parse_data' do
        Mock_http = Struct.new(:body, :user)
        data = Mock_http.new
        data.user = score_card.data[:user]
        data.body = "{}"
        score_card.stub :data, (data) do
          assert score_card.send(:data_to_json)
        end
      end

      it '#get_events' do
        json = [
          {'id' => '123', 'type' => 'IssuesEvent'},
          {'id' => '123', 'type' => 'IssuesEvent'},
          {'id' => '456', 'type' => 'AnyOtherEvent'},
        ]
        expect = ['IssuesEvent', 'IssuesEvent', 'AnyOtherEvent']
        assert_equal expect, score_card.send(:get_events, json)
      end

      it '#event_count' do
        total = [
          'IssuesEvent',
          'IssuesEvent',
          'IssuesEvent',
          'AnyOtherEvent',
        ]
        expect = {
          'IssuesEvent' => 3,
          'AnyOtherEvent' => 1
        }
        assert_equal expect, score_card.send(:event_count, total)
      end

      it '#score_events' do
        freqency = {
          'IssuesEvent' => 3,
          'AnyOtherEvent' => 1
        }
        expect = 22
        assert_equal expect, score_card.send(:score_events, freqency)
      end
    end
  end
end