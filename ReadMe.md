## To Start up Sinatra
$ rackup config.ru 

 * In order to run RSpec, the class (`i-scream-microservice-app.rb) has to be defined
 * If the RESTful routes (`get` `post`...) are wrapped inside of a class (`IScreamMicroservice`) then the class needs to be called
 * config.ru (ru stands for rackup) will run the class
 * config.ru uses `localhost:9292`

 ## To Hide API Key
 1. create file to be ignored 
  $ touch api_keys.rb
 2. add `GAME_API: <key goes here>` to `/api_keys.rb`
 3. make sure `/api_keys.rb` is in `.gitignore`
