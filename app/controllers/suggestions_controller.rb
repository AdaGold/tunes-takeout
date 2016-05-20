require "#{Rails.root}/lib/charles/TunesTakeoutWrapper.rb"
require "#{Rails.root}/app/models/music.rb"
require 'rspotify'

class SuggestionsController < ApplicationController
  def index
    @all_suggestions = Charles::TunesTakeoutWrapper.find(params[:user_input])

    if @all_suggestions.suggestions.nil?
      flash.now[:notice] = "Something went wrong, please try again"
    else

      @music = @all_suggestions.suggestions.map do |sugg_hash|
        Music.create(sugg_hash["music_type"], sugg_hash["music_id"])
      end

      @food = @all_suggestions.suggestions.map do |sugg_hash|
        Food.find_in_api(sugg_hash["food_id"])
      end

      @zip = @music.zip @food

    end
    render :index
  end

  def favorite

    Charles::TunesTakeoutWrapper.add_favorite(params["suggestion_id"])
  end

  def favorites
    @top = Charles::TunesTakeoutWrapper.all_favorites

    if @top.nil?
      flash.now[:notice] = "Something went wrong, please try again"
    else

      @music = @top.suggestions.map do |sugg_hash|
        Music.create(sugg_hash["suggestion"]["music_type"], sugg_hash["suggestion"]["music_id"])
      end

      @food = @top.suggestions.map do |sugg_hash|
        Food.find_in_api(sugg_hash["food_id"])
      end

      @zip = @music.zip @food
    end
  end

  def unfavorite
  end
end
