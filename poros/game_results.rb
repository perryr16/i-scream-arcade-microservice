
class GameResults
  
  def service 
    GameService.new
  end

  def game_params_by_name(game_name)
    return "Invalid Game Name" if service.get_games_by_name(game_name).empty?
    params = service.get_games_by_name(game_name)[0]
    result = {data: {
      age_ratings:  run_array(:get_age_ratings, :rating, params[:age_ratings]), # array of ids
      release_date: Time.at(params[:first_release_date]).year, # Unix Time
      cover:        "https:#{cover_url(params[:cover])}",
      popularity:   params[:popularity], # good
      summary:      params[:summary], # good
      name:         params[:name], # good
      total_rating: params[:total_rating], # good
      categories:   params[:category], # got 0
      genres:       run_array(:get_game_genres, :name, params[:genres]), # array of ids
      keywords:     params[:keywords], # array of ids -- several hundred :(
      platforms:    run_array(:get_platforms, :name, params[:platforms]), # array of ids
      similars:     run_array(:get_games_by_id, :name, params[:similar_games]), # array of ids
      screenshots:  format_screenshots(params), # array of ids
      themes:       run_array(:get_game_themes, :name, params[:themes]), # array of ids
      # video:       "https://www.youtube.com/watch?v=#{youtube_id(params[:videos][0])}" # good -> array of ids
      video:        "#{youtube_id(params[:videos][0])}" # good -> array of ids
    }}
  end

  def run_array(method, key, array)
    return nil if !array.is_a?(Array)
    array.map do |element|
      service.send(method,element)[0][key]
    end
  end

  def cover_url(cover_id)
    cover_data = service.get_cover(cover_id) # id
    return nil if !cover_data.is_a?(Array)
    cover_data[0][:url]
  end
  
  def youtube_id(video_id)
    # binding.pry
    return nil if !video_id.is_a?(Array)
    service.get_game_videos(video_id[0])[0][:video_id]
  end

  def keyword_id(word)
    {data: service.get_keyid(word)[0]}
  end

  def keyid(id)
    {data: service.get_keyword(id)[0]}
  end

  def generate_ids(words)
    ids = words.map do |word|
      service.get_keyword(word)[0][:id]
    end
  end

  def format_screenshots(params)
    return nil if !params[:screenshots].is_a?(Array)
    screenshots = run_array(:get_screenshots, :url, params[:screenshots])
    screenshots.map {|screenshot| "https:" + screenshot}
  end

  def find_games_with_keywords(words)
    ids = generate_ids(words)
    games = service.get_games_by_keywords(ids)
  end
    
  def find_games_with_keyids(ids)
    games = service.get_games_by_keywords(ids)
  end

  def games_by_keyids(ids)
    game_arrays = service.get_games_by_keyids(ids)
    game_arrays.map do |game| 
      # binding.pry
    result = { data: {
      age_ratings:  run_array(:get_age_ratings, :rating, game[:age_ratings]), # array of ids
      release_date: Time.at(game[:first_release_date]).year, # Unix Time
      cover:        "https:#{cover_url(game[:cover])}",
      popularity:   game[:popularity], # good
      summary:      game[:summary], # good
      name:         game[:name], # good
      total_rating: game[:total_rating], # good
      categories:   game[:category], # got 0
      genres:       run_array(:get_game_genres, :name, game[:genres]), # array of ids
      keywords:     game[:keywords], # array of ids -- several hundred :(
      platforms:    run_array(:get_platforms, :name, game[:platforms]), # array of ids
      similars:     run_array(:get_games_by_id, :name, game[:similar_games]), # array of ids
      screenshots:  format_screenshots(game), # array of ids
      themes:       run_array(:get_game_themes, :name, game[:themes]), # array of ids
      videos:       "https://www.youtube.com/watch?v=#{youtube_id(game[:videos])}" # good -> array of ids
      }}
    end
  end

  def keywords_to_games(keywords)
    keyword_array = keywords.split(',')
    results = keyword_array.map do |keyword| 
      key_id = service.get_keyids_from_keywords(keyword)
      if key_id == []
        nil
      else 
        key_id[0][:id]
      end
    end.compact.join(',')
    {data: games_by_keyids(results)}
  end
end