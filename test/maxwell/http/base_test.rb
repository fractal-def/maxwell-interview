require "test_helper"

class Maxwell::Http::BaseTest < Minitest::Test
  describe 'HTTP Base' do

    let (:url) { 'https://api.github.com/' }
    let (:path) { 'users/dhh/events/public' }
    let (:base) { Maxwell::Http::Base.new(url: url, path: path) }
    let (:http) { HTTParty }
    let (:fake_response) { Struct.new(:code, :body) }
    let (:response_stub) { fake_response.new }

    it 'Instance identity' do
      assert_instance_of Maxwell::Http::Base, base
    end

    describe 'attributes' do
      it '#url' do assert_equal url, base.url end
      it '#path' do assert_equal path, base.path end
    end

    describe 'methods' do
      it '#get' do
        response_stub.body = base
        base.stub :request, (response_stub) do
            assert_equal(base, base.get)
        end
      end

      it '#status_code' do
        response_stub.code = 200
        base.stub :request, (response_stub) do
            assert_equal 200, base.get.status_code
        end
      end
    end
  end
end