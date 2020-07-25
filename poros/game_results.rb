
class GameResults
  
  def service 
    GameService.new
  end

  def game_params_by_name(game_name)
    params = service.get_games_by_name(game_name)[0]
    binding.pry
    {
      age_ratings:  params[:age_ratings],
      cover:        params[:cover],
      release_date: params[:first_release_date],
      popularity:   params[:popularity],
      summary:      params[:summary],
      name:         params[:name],
      total_rating: params[:total_rating],
      categories:   params[:categories],
      genres:       params[:genres],
      keywords:     params[:keywords],
      platforms:    params[:platforms],
      similars:     params[:similar_games],
      themes:       params[:themes]
    }
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