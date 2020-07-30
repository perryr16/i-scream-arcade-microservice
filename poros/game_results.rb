
class GameResults
  
  def service 
    GameService.new
  end

  def game_result(params)
    result = {data: {
      age_ratings:  run_array(:get_age_ratings, :rating, params[:age_ratings]), 
      release_date: Time.at(params[:first_release_date]).year, 
      cover:        "https:#{cover_url(params[:cover])}",
      popularity:   params[:popularity],
      summary:      params[:summary],
      name:         params[:name],
      total_rating: params[:total_rating],
      categories:   params[:category],
      genres:       run_array(:get_game_genres, :name, params[:genres]), 
      keywords:     params[:keywords],
      platforms:    run_array(:get_platforms, :name, params[:platforms]), 
      similars:     run_array(:get_games_by_id, :name, params[:similar_games]), 
      screenshots:  format_screenshots(params), 
      themes:       run_array(:get_game_themes, :name, params[:themes]), 
      video:        "#{youtube_id(params[:videos])}"
    }}
  end

  def game_params_by_name(game_name)
    return "Invalid Game Name" if service.get_games_by_name(game_name).empty?
    params = service.get_games_by_name(game_name)[0]
    game_result(params)
  end

  def run_array(method, key, array)
    return nil if !array.is_a?(Array)
    array.map do |element|
      service.send(method,element)[0][key]
    end
  end

  def cover_url(cover_id)
    cover_data = service.get_cover(cover_id) 
    return nil if !cover_data.is_a?(Array)
    cover_data[0][:url]
  end
  
  def youtube_id(video_id)
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


  def games_by_keyids(ids)
    game_arrays = service.get_games_by_keyids(ids)
    game_arrays.map do |game| 
      game_result(game)
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
    return 'Invalid Keyword' if results.empty?
    {data: games_by_keyids(results)}
  end
end