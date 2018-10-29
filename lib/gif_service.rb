require_relative 'http_client'

class GIFService
  Non200ResponseError = Class.new(StandardError)
  class << self
    def random_gif(client = HTTPClient)
      response = client.get(
        base_url_endpoint + random_gif_endpoint,
        query_params
      )

      return get_embed_url(response) if response.code.between?(200, 299)

      raise Non200ResponseError
    end

    private

    def base_url_endpoint
      ENV.fetch('GIF_SERVICE_ENDPOINT')
    end

    def random_gif_endpoint
      '/v1/gifs/random'
    end

    def api_key
      ENV.fetch('GIF_SERVICE_API_KEY')
    end

    def query_params
      {
        query: { api_key: api_key, rating: 'g' }
      }
    end

    def get_embed_url(response)
      response.parsed_response['data']['embed_url']
    end
  end
end
