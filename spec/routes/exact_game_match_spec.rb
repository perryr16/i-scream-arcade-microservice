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

  it "returns the key id of key words" , :vcr do
    get '/keyword/spider'

    expected = "{\"data\":{\"id\":4235,\"name\":\"spider\"}}"
    exp_id  = "\"id\":4235"
    exp_word  = "\"name\":\"spider\""

    expect(last_response.body).to include(expected)
    expect(last_response.body).to include(exp_id)
    expect(last_response.body).to include(exp_word)
  end

  it "returns the keyword of key id", :vcr do
    get '/keyid/16'

    exp_id  = "\"id\":16"
    exp_word  = "\"name\":\"ghosts\""

    expect(last_response.body).to include(exp_id)
    expect(last_response.body).to include(exp_word)
  end

  it "returns game information from exact match", :vcr do
    get "/game/Mario%20Kart%2064"

    exp_age_rating = "\"age_ratings\":[8]"
    exp_release_date = "\"release_date\":1996"
    exp_cover = "\"cover\":\"https://images.igdb.com/igdb/image/upload/t_thumb/co1te8.jpg\""
    exp_popularity = "\"popularity\":5.457862054247628"
    exp_summary = "\"summary\":\"Mario Kart 64 is the second main installment of the Mario Kart series. It"
    exp_name = "\"name\":\"Mario Kart 64\""
    exp_total_rating = "\"total_rating\":81.79204527809605"
    exp_categories = "\"categories\":0"
    exp_genres = "\"genres\":[\"Racing\",\"Sport\"]"
    exp_keywords = "\"keywords\":[25,280,281"
    exp_platforms = "\"platforms\":[\"Nintendo 64\",\"Wii\",\"Wii U\"]"
    exp_similars = "\"similars\":[\"Super Mario Bros.\",\"Crash Team Racing\",\"Crash Nitro Kart\",\"Super Mario Kart\",\"Mario Kart: Super Circuit\",\"Mario Kart DS\",\"Mario Kart 7\",\"Mario Kart 8\",\"Paper Mario: The Thousand-Year Door\"]"
    exp_screenshots = "\"screenshots\":[\"https://images.igdb.com/igdb/image/upload/t_thumb/sc87rl.jpg\",\"https://images.igdb.com/igdb/image/upload/t_thumb/sc87rm.jpg\",\"https://images.igdb.com/igdb/image/upload/t_thumb/sc87rn.jpg\""
    exp_themes = "\"themes\":[\"Action\",\"Kids\"]"
    exp_video = "\"video\":\"ASWgJvuQhTA\""

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
    expect(last_response.body).to include(exp_video)

  end


   it "returns games by 2 keyword", :vcr do
    get '/keywords_to_games/spider,ghost'

    body = JSON.parse(last_response.body, symbolize_names: true)
    expect(body[:data].length).to eq(10)
    expect(body[:data][0][:data][:release_date].present?).to eq(true)
    expect(body[:data][4][:data][:release_date].present?).to eq(true)
    expect(body[:data][9][:data][:release_date].present?).to eq(true)

    game1_keywords = body[:data][0][:data][:keywords]
    game5_keywords = body[:data][4][:data][:keywords]
    game10_keywords = body[:data][9][:data][:keywords]

    exp_keyids = [4235,8972]
    expect((game1_keywords & exp_keyids).present?).to eq(true)
    expect((game5_keywords & exp_keyids).present?).to eq(true)
    expect((game10_keywords & exp_keyids).present?).to eq(true)
   end

   it "returns nil by if bad keyword", :vcr do
    get '/keywords_to_games/not_a_keyword_2f2asdf4'

    expect(last_response.body).to eq("\"Invalid Keyword\"")
   end
  

end
