require 'spec_helper'
require 'rack/test'

require './gifinity'

RSpec.describe 'gifinity' do
  include Rack::Test::Methods
  describe 'GET /random' do
    it 'returns a 200' do
      def app
        Sinatra::Application
      end

      allow(GIFService).to receive(:random_gif).and_return('foo.com')

      get '/random'
      expect(last_response).to be_ok
    end

    it 'returns an embeded gif' do
      def app
        Sinatra::Application
      end

      allow(GIFService).to receive(:random_gif).and_return('foo.com')

      get '/random'
      expect(last_response.body).to eq '<embed src=foo.com>'
    end
  end
end
