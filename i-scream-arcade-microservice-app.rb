require 'sinatra'
require 'sinatra/json'
require 'json'
require 'faraday'
require 'pry'
require './services/game_service'
require './poros/game_results'



class IScreamMicroservice < Sinatra::Base
  
  results = GameResults.new

  get '/game/:game_title' do
    json results.game_params_by_name(params[:game_title])
  end
  
  get '/keyword/:keyword' do 
    json results.keyword_id(params[:keyword])
  end

  get '/keyid/:keyid' do 
    json results.keyid(params[:keyid])
  end

  get '/' do 
    "hit the following routes '/game/:game_title', '/keyword/:keyword', '/keyid/:keyid', '/keywords_to_games/:keywords' "
  end

  get '/keywords_to_games/:keywords' do
    json results.keywords_to_games(params[:keywords])
  end

end
