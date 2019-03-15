require "test_helper"
require_relative '../../lib/http/base'

class Http::BaseTest < Minitest::Test
  describe 'HTTP Base' do

    let (:url) { 'https://api.github.com/' }
    let (:path) { 'users/dhh/events/public' }
    subject { Http::Base.new(url: url, path: path) }
    let (:http) { HTTParty }
    let (:fake_response) { Struct.new(:code, :body) }
    let (:response_stub) { fake_response.new }

    it 'Instance identity' do
      assert_instance_of Http::Base, subject
    end

    describe 'attributes' do
      it '#url' do assert_equal url, subject.url end
      it '#path' do assert_equal path, subject.path end
    end

    describe 'methods' do
      it '#get' do
        response_stub.body = subject
        subject.stub :request, (response_stub) do
            assert_equal(subject, subject.get)
        end
      end

      it '#status_code' do
        response_stub.code = 200
        subject.stub :request, (response_stub) do
            assert_equal 200, subject.get.status_code
        end
      end
    end
  end
end