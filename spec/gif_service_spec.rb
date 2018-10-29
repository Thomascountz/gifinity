require 'spec_helper'

require './lib/gif_service'

RSpec.describe GIFService do
  describe '.random_gif' do
    context '3rd-party api returns OK' do
      it 'returns a URL of a GIF' do
        allow(ENV).to receive(:fetch).with('GIF_SERVICE_ENDPOINT').and_return('gif_endpoint')
        allow(ENV).to receive(:fetch).with('GIF_SERVICE_API_KEY').and_return('api_key')

        mock_client = class_double(HTTPClient)
        parsed_response = { 'data' => { 'embed_url' => 'foo.com' } }
        client_response = Struct.new(:code, :parsed_response).new(200, parsed_response)

        allow(mock_client).to receive(:get).and_return(client_response)

        gif_url = GIFService.random_gif(mock_client)

        expect(gif_url).to eq('foo.com')
      end
    end
  end

  context '3rd-party api returns a non-200' do
    it 'raises an error' do
      allow(ENV).to receive(:fetch).with('GIF_SERVICE_ENDPOINT').and_return('gif_endpoint')
      allow(ENV).to receive(:fetch).with('GIF_SERVICE_API_KEY').and_return('api_key')

      mock_client = class_double(HTTPClient)
      client_response = Struct.new(:code).new(404)

      allow(mock_client).to receive(:get).and_return(client_response)

      expect { GIFService.random_gif(mock_client) }.to raise_error(GIFService::Non200ResponseError)
    end
  end
end
