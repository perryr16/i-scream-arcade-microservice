require 'sinatra'
require 'faraday'
require 'pry'
require './services/game_service'
require './poros/game_results'


# game_title = "Mario$20Kart%2064"
get '/game/:game_title' do

  results = GameResults.new

  results.game_params_by_name(params[:game_title]).to_json

end

var = 'dog'
get "/cats/:name" do
  binding.pry
  "meeeeooowww"
end

# require 'sinatra'
get '/hello' do 
  status 200 
  {message: 'hellow world!'}.to_json
end
get '/' do 
  'what up dogs'
end
get '/dogs' do 
  'What up dog'
end