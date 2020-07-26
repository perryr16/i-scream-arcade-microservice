
class GameResults
  
  def service 
    GameService.new
  end

  def game_params_by_name(game_name)
    params = service.get_games_by_name(game_name)[0]
    result = {data: {
      age_ratings:  run_array(:get_age_ratings, :rating, params[:age_ratings]), # array of ids
      release_date: Time.at(params[:first_release_date]).year, # id
      cover:        cover_url(params[:cover]),
      popularity:   params[:popularity], # good
      summary:      params[:summary], # good
      name:         params[:name], # good
      total_rating: params[:total_rating], # good
      categories:   params[:category], # got 0
      genres:       run_array(:get_game_genres, :name, params[:genres]), # array of ids
      keywords:     params[:keywords], # array of ids -- several hundred :(
      platforms:    run_array(:get_platforms, :name, params[:platforms]), # array of ids
      similars:     run_array(:get_games_by_id, :name, params[:similar_games]), # array of ids
      screenshots:  run_array(:get_screenshots, :url, params[:screenshots]), # array of ids
      themes:       run_array(:get_game_themes, :name, params[:themes]), # array of ids
      videos:       youtube_id(params[:videos][0]) # good -> array of ids
    }}
  end

  def run_array(method, key, array)
    array.map do |element|
      service.send(method,element)[0][key]
    end
  end

  def cover_url(cover_id)
    service.get_cover(cover_id)[0][:url] # id
  end
  
  def youtube_id(video_id)
    service.get_game_videos(video_id)[0][:video_id]
  end

  def keyword_id(word)
    {data: service.get_keyid(word)[0]}
  end

  def keyid(id)
    service.get_keyword(id)
  end

  def generate_ids(words)
    ids = words.map do |word|
      service.get_keyword(word)[0][:id]
    end
  end

  def find_games_with_keywords(words)
    ids = generate_ids(words)
    games = service.get_games_by_keywords(ids)
  end
    
  def find_games_with_keyids(ids)
    games = service.get_games_by_keywords(ids)
  end
    

end