require "#{Rails.root}/lib/charles/TunesTakeoutWrapper.rb"

class SuggestionsController < ApplicationController
before_action :require_login, only: [:favorites, :favorite, :unfavorites, :search_result]
  def index
    @top = Charles::TunesTakeoutWrapper.all_favorites

    if @top.nil?
      flash.now[:notice] = "Something went wrong, please try again"
    else
      @zip = @top.suggestions.map do |sugg_hash|
        [
        Music.create(sugg_hash["suggestion"]["music_type"], sugg_hash["suggestion"]["music_id"]),
        Food.find_in_api(sugg_hash["suggestion"]["food_id"]),
        sugg_hash["suggestion"]["id"]
        ]
      end
    end
  end

  def favorites
    @my_favorites = Charles::TunesTakeoutWrapper.get_my_favorite(current_user.uid)

    if @my_favorites.suggestions.nil?
      flash.now[:notice] = "Something went wrong, please try again"
    else
      @zip = @my_favorites.suggestions.map do |sugg_hash|
        [
        Music.create(sugg_hash['suggestion']["music_type"], sugg_hash['suggestion']["music_id"]),
        Food.find_in_api(sugg_hash['suggestion']["food_id"]),
        sugg_hash['suggestion']["id"]
        ]
      end
    end
  end

  def favorite
    @result = Charles::TunesTakeoutWrapper.add_favorite(params[:current_user_id], params[:suggestion_id])
    redirect_to my_favorites_path
  end

  def unfavorite
  end

  def search_result
    @all_suggestions = Charles::TunesTakeoutWrapper.find(params[:user_input])

    if @all_suggestions.suggestions.nil?
      flash.now[:notice] = "Something went wrong, please try again"
    else
      @zip = @all_suggestions.suggestions.map do |sugg_hash|
        [
        Music.create(sugg_hash["music_type"], sugg_hash["music_id"]),
        Food.find_in_api(sugg_hash["food_id"]),
        sugg_hash["id"]
        ]
      end
    end
  end
end
