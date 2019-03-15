require 'HTTParty'

  module Http
    class Base
      include HTTParty
      attr_reader :url, :path, :response

      AUTH = {
        username: ENV['GITHUB_USERNAME'],
        password: ENV['GITHUB_PASSWORD']
      }

      def initialize(url:, path:)
        @url = url
        @path = path
      end

      def get
        @response = request(:get, url, path)
        self
      end

      def status_code
        response.code
      end

      def body
        response.body
      end

      private

      def request(method, url, path)
        self.class.send(method, "#{url}#{path}",
          headers)
      end

      def headers
        { basic_auth: {
          username: AUTH[:username],
          password: AUTH[:password]
        }
      }
    end
  end
end
