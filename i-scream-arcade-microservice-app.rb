require 'sinatra'
require 'sinatra/json'
require 'json'
require 'faraday'
require 'pry'
require './services/game_service'
require './poros/game_results'

# require './serializers/keyword_serializer'

# before do
#  content_type :json
# end

# game_title = "Mario$20Kart%2064"
results = GameResults.new

get '/game/:game_title' do
  json results.game_params_by_name(params[:game_title])
end

get '/keyword/:keyword' do 
  json body results.keyword_id(params[:keyword])
end

get '/dog' do 
  body 'what up dog'
end

# get '/foo' do
#   body "bar"
# end

# after do
#   puts body
# end


