SCORES = {
  IssuesEvent: 7,
  IssueCommentEvent: 6,
  PushEvent: 5,
  PullRequestReviewCommentEvent: 4,
  WatchEvent: 3,
  CreateEvent: 2,
  AnyOtherEvent: 1
}

module Maxwell
  class ScoreCard
    attr_reader :http, :user, :data, :scores

    def initialize(user: 'dhh', http: Http::GithubUsers, scores: SCORES)
      @user = user
      @http = http.new(user: user)
      @scores = scores
      data
    end

    def score
      events      = get_events(data_to_json)
      event_count = event_count(events)
      score_events(event_count)
    end

    def data
      @data ||= http.get
    end

  private

    def data_to_json
      JSON.parse(data.body)
    end

    def get_events(events)
      events.map { |event| event['type'] }
    end

    def event_count(total)
      total.inject(Hash.new(0)) do |event, count|
        event[count] += 1
        event
      end
    end

    def score_events(event_quantity)
      event_quantity.map do |event, quantity|
        if scores[event.to_sym].nil?
          scores[:AnyOtherEvent]
        else
          scores[event.to_sym] * quantity
        end
      end.reduce(:+)
    end
  end
end