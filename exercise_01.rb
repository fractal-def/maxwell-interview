require "httparty"

class DHHGithubEventScoring
  EVENTS = {
    "issuesevent" => 7,
    "issuecommentevent" => 6,
    "pushevent" => 5,
    "pullrequestreviewcommentevent" => 4,
    "watchevent" => 3,
    "createevent" => 2
  }
  OTHER_EVENT = 1
  DHH_URL = "https://api.github.com/users/dhh/events/public"

  def execute
    score = score_events(get)
    result(score)
  end

  private
  def get
    response = HTTParty.get(DHH_URL)
    parsed = response.parsed_response
    p "Number of commits #{parsed.size}"
    parsed
  end

  def score_events(response)
    response.reduce(0) do |sum, obj|
      type = obj.fetch("type", false)
      if type
        sum += EVENTS.fetch(type.downcase, OTHER_EVENT)
      end
    end
  end

  def result(score)
    p "DHH's github score is #{score}"
  end
end

DHHGithubEventScoring.new.execute