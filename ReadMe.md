## About 
This is a sinatra microservice whose primary duty is to serve the rails based app `I Scream Aracade` and can be viewed at `https://i-scream-arcade.herokuapp.com/`. To use this microservice in production you can access it at `https://i-scream-microservice.herokuapp.com/`

This microservice accesses the IGDB (Internet Game DataBase) API to return vidoe game based data. The microservice formats the data as a JSON response and is exposed through the following endpoints:
* `/` - A basic splash screen showing available routes
* `/game/:game_title` - Returns game data given an *exact* game name
* `/keyword/:keyword` - Game Keywords come back as an id. To determine the value of that key-id, enter the keyword.
* `/keyid/:keyid` - A reverse keyword search that will produce the name of the keyword given its id
* `/keywords_to_games/:keywords` - The microservices primary function is to return games that contain the given keywords. Keywords must be entered with commas between without spaces. ex: `keywords_to_games/spider,cat,ghost`

## Team Members

[Mariana Cid](https://github.com/Mariana-21)

[Whitney Kidd](https://github.com/whitneykidd)

[Ross Perry](https://github.com/perryr16)

[Melanie Tran](https://github.com/melatran)


## To Start up Sinatra
`$ bundle install`
`$ rails g rspec:install`
`$ shotgun`
* The server will run locally on `localhost:9393`
* To run on a differnt server, run `$ shotgun -p <server number>`
* Shotgun is a ruby gem that will allow for automatic code reloading (instead of having to stop and restart the service)


## To Hide API Key
 1. Open `.env`
 2. Enter API key as follows `export <API_KEY_NAME>=<API_KEY>`
 3. Use in app as `ENV['API_KEY_NAME]`
 4. File must contain `Dotenv.load`

## To Run without Shotgun
`$ rackup config.ru`

 * In order to run RSpec, the class (`i-scream-microservice-app.rb`) has to be defined
 * If the RESTful routes (`get` `post`...) are wrapped inside of a class (`IScreamMicroservice`) then the class needs to be called
 * config.ru will run the class
 * config.ru uses `localhost:9292`

 ## Testing
* This app uses VCR to mock and stub real data. Fixtures are saved in `/spec/fixtures`. To run the test suite run the following once only.
`$ bundle install`
`$ rails g rspec:install`
`$ shotgun`
* After the server is running, run 
`$ bundle exec rspec`
* To populate the microservice with fresh data delete the fixture files in `/spec/fixtures` and rerun `$ bundle exec rspec`

