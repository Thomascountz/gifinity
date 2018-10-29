require 'httparty'

class HTTPClient
  def self.get(endpoint, *args)
    HTTParty.get(endpoint, *args)
  end
end
