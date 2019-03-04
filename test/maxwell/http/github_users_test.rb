require "test_helper"

class Maxwell::Http::GithubUsersTest < Minitest::Test
  describe 'Github User API' do

    let (:request) { Maxwell::Http::GithubUsers.new(base: mock_base) }

    let (:user) { 'dhh' }
    let (:url) { 'https://api.github.com/' }
    let (:path) { "users/#{user}/events/public" }

    let (:mock_base) { Struct.new(:get) }
    let (:mock_request) { Struct.new(:body, :status_code) }
    let (:mock_response) { mock_request.new }

    before do
      mock_response.status_code = 200
      mock_response.body = "{}"
      request.base.get = mock_response
    end

    it 'Instance identity' do
      assert_instance_of Maxwell::Http::GithubUsers, request
    end

    describe 'attributes' do
      it '#url' do assert_equal(url, request.url) end
      it '#user' do assert_equal user, request.user end
      it '#path' do assert_equal path, request.path end
    end

    describe 'methods' do
      it '#get' do
        assert_equal request, request.get
      end

      it '#status_code' do
        assert_equal mock_response.status_code, request.get.status_code
      end

      it '#body' do
        assert_equal(mock_response.body, request.get.body)
      end
    end
  end
end