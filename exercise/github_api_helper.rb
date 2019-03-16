# frozen_string_literal: true

module GithubAPIHelper
  API_HOST = 'api.github.com'

  def http_get(path)
    parse_or_raise_response do
      Net::HTTP.start(API_HOST, 443, use_ssl: true) do |http|
        http.request_get(path)
      end
    end
  end

  def parse_or_raise_response
    response = yield
    response.code == '200' ? JSON.parse(response.body) : response.value
  end
end
