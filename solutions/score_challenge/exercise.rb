require 'faraday'
require 'json'

def count_events(response_body)
  event_type_count = {}

  JSON.parse(response_body).each do |event|
    if event["type"]
      if event_type_count[event["type"]]
        event_type_count[event["type"]] = event_type_count[event["type"]] + 1
      else
        event_type_count[event["type"]] = 1
      end
    end
  end

  event_type_count
end

def event_counts_message(event_type_count)
  if event_type_count.size > 0
    event_type_count.map do |k, v|
      <<~HEREDOC
        #{k} = #{v}
      HEREDOC
    end
  end
end

def score_challenge(username = 'dhh')
  response = Faraday.get "https://api.github.com/users/#{username}/events/public"

  if response.status == 200
    puts event_counts_message(count_events(response.body))
  else
    puts "<production grade logging/metric action here> #{response.body}"
  end
end

score_challenge
