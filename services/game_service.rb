require 'faraday'
require 'dotenv'
Dotenv.load

class GameService



  def get_games_by_name(game)
    response = conn.get('/games') do |res|
      res.body = "fields *; where name = \"#{game}\";"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end
  
  def get_games_by_id(game_id)
    response = conn.get('/games') do |res|
      res.body = "fields *; where id = #{game_id};"
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

  def get_keyid(word)
    response = conn.get("/keywords") do |res|
      res.body = "fields id, name; where name = \"#{word}\";" 
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_keyword(key_id)
    response = conn.get("/keywords") do |res|
      res.body = "fields id, name; where id = #{key_id};" 
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_game_videos(video_id)
    response = conn.get("/game_videos") do |res|
      res.body = "fields *; where id = #{video_id};"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_game_themes(theme_id)
    response = conn.get("/themes") do |res|
      res.body = "fields *; where id = #{theme_id};"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_game_genres(genre_id)
    response = conn.get("/genres") do |res|
      res.body = "fields *; where id = #{genre_id};"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_platforms(platform_id)
    response = conn.get("/platforms") do |res|
      res.body = "fields *; where id = #{platform_id};"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_screenshots(screenshot_id)
    response = conn.get("/screenshots") do |res|
      res.body = "fields *; where id = #{screenshot_id};"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_cover(cover_id)
    response = conn.get("/covers") do |res|
      res.body = "fields *; where id = #{cover_id};"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def get_age_ratings(age_rating_id)
    response = conn.get("/age_ratings") do |res|
      res.body = "fields *; where id = #{age_rating_id};"
    end
    body = JSON.parse(response.body, symbolize_names: true)
  end


  private

  def conn 
    Faraday.new('https://api-v3.igdb.com') do |res|
      # res.headers["user-key"] = GAME_API
      res.headers["user-key"] = ENV['GAME_API']
    end
  end
  
end
  