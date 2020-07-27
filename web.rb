require 'sinatra'
get '/hello' do 
  status 200 
  {message: 'hellow world!'}.to_json
end
get '/' do 
  'Splash'
end