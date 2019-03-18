require_relative './base'

  module Http
    class GithubUsers
      attr_reader :url, :user, :path, :response, :base

      URL = 'https://api.github.com/'

      def initialize(user:'dhh', base: Base)
        @url = URL
        @user = user
        @path = "users/#{user}/events/public"
        @base = base.new(url: url, path: path)
      end

      def get
        @response = base.get
        self
      end

      def status_code
        response.status_code
      end

      def body
        response.body
      end
    end
  end
