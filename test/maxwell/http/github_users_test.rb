require "test_helper"

class Maxwell::Http::GithubUsersTest < Minitest::Test
  describe 'Github User API' do
    let (:user) { 'dhh' }
    let (:request) { Maxwell::Http::GithubUsers.new(user: user) }
    let (:url) { 'https://api.github.com/' }
    let (:path) { "users/#{user}/events/public" }
    let (:base) { Maxwell::Http::Base }
    let (:fake_response) { Struct.new(:code, :body) }
    let (:response_stub) { fake_response.new }

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
        response_stub.code = 200
        base.stub :get, (response_stub) do
            assert_equal request, request.get
        end
      end

      it '#status_code' do
        response_stub.code = 200
        base.stub :get, (response_stub) do
            assert_equal 200, request.get.status_code
        end
      end

      it '#body' do
        response_stub.body = {}
        base.stub :get, (response_stub) do
            assert_equal({}, request.get.body)
        end
      end
    end
  end
end