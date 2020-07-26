require './i-scream-arcade-microservice-app'
require 'rack/test'


RSpec.describe IScreamMicroservice do
  include Rack::Test::Methods
  def app
    IScreamMicroservice.new # this defines the active application for this test
  end

  it "test" do
    get '/dog'

    expect(last_response.body).to include("what up dog")
  end

  it "returns the key id of key words" do
    get '/keyword/spider'

    expected = "{\"data\":{\"id\":4235,\"name\":\"spider\"}}"
    exp_id  = "\"id\":4235"
    exp_word  = "\"name\":\"spider\""

    expect(last_response.body).to include(expected)
    expect(last_response.body).to include(exp_id)
    expect(last_response.body).to include(exp_word)
  end

  it "returns game information from exact match" do
    get "/game/Mario%20Kart%2064"

    exp_age_rating = "\"age_ratings\":[8]"
    exp_release_date = "\"release_date\":1996"
    exp_cover = "\"cover\":\"//images.igdb.com/igdb/image/upload/t_thumb/co1te8.jpg\""
    exp_popularity = "\"popularity\":5.457862054247628"
    exp_summary = "\"summary\":\"Mario Kart 64 is the second main installment of the Mario Kart series. It"
    exp_name = "\"name\":\"Mario Kart 64\""
    exp_total_rating = "\"total_rating\":81.79204527809605"
    exp_categories = "\"categories\":0"
    exp_genres = "\"genres\":[\"Racing\",\"Sport\"]"
    exp_keywords = "\"keywords\":[25,280,281"
    exp_platforms = "\"platforms\":[\"Nintendo 64\",\"Wii\",\"Wii U\"]"
    exp_similars = "\"similars\":[\"Super Mario Bros.\",\"Crash Team Racing\",\"Crash Nitro Kart\",\"Super Mario Kart\",\"Mario Kart: Super Circuit\",\"Mario Kart DS\",\"Mario Kart 7\",\"Mario Kart 8\",\"Paper Mario: The Thousand-Year Door\"]"
    exp_screenshots = "\"screenshots\":[\"//images.igdb.com/igdb/image/upload/t_thumb/sc87rl.jpg\",\"//images.igdb.com/igdb/image/upload/t_thumb/sc87rm.jpg\",\"//images.igdb.com/igdb/image/upload/t_thumb/sc87rn.jpg\""
    exp_themes = "\"themes\":[\"Action\",\"Kids\"]"
    exp_videos = "\"videos\":\"ASWgJvuQhTA\""

    expect(last_response.body).to include(exp_age_rating)
    expect(last_response.body).to include(exp_release_date)
    expect(last_response.body).to include(exp_cover)
    expect(last_response.body).to include(exp_popularity)
    expect(last_response.body).to include(exp_summary)
    expect(last_response.body).to include(exp_name)
    expect(last_response.body).to include(exp_total_rating)
    expect(last_response.body).to include(exp_categories)
    expect(last_response.body).to include(exp_genres)
    expect(last_response.body).to include(exp_keywords)
    expect(last_response.body).to include(exp_platforms)
    expect(last_response.body).to include(exp_similars)
    expect(last_response.body).to include(exp_screenshots)
    expect(last_response.body).to include(exp_themes)
    expect(last_response.body).to include(exp_videos)


  end
  
  

end
