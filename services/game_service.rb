require 'faraday'

class GameService

GAME_API = '177f68493b7f48e7c3deaf6d5a815ff0'

  def get_games_by_name(game)
    response = conn.get('/games') do |res|
      res.body = "fields *; where name = \"#{game}\";"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_games_by_keywords(ids)
    id_list =  ids.join(",")
    response = conn.get('/games') do |res|
      res.body = "fields name, summary, rating, keywords; 
                  where keywords = [#{id_list}]
                  & rating > 1; 
                  sort rating desc;"
      # NOTE: [] is AND, () is OR
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_keyword(word)
    response = conn.get("/keywords") do |res|
      res.body = "fields id, name; where name = \"#{word}\";" 
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_game_videos(video_id)
    response = conn.get("/game_videos") do |res|
      res.body = "fields *; where id = #{video_id};"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn 
    Faraday.new('https://api-v3.igdb.com') do |res|
      res.headers["user-key"] = GAME_API
      # res.headers["user-key"] = ENV['GAME_API']
    end
  end
  
end
  