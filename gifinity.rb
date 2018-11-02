require 'sinatra'
require 'dotenv/load'

require_relative './lib/gif_service'

get '/' do
  redirect '/random'
end

get '/random' do
  embed(GIFService.random_gif)
end

def embed(url)
  "<embed src=#{url}>"
end
