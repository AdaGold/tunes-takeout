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

      @charles_ids =  @all_suggestions.suggestions.map { |sugg_hash| sugg_hash["id"]}
      @zip = @music.zip(@food, @charles_ids)
    end
    render :index
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

      @charles_ids =  @top.suggestions.map { |sugg_hash| sugg_hash["suggestion"]["id"]}

      @zip = @music.zip(@food, @charles_ids)
    end
  end

  def favorite(current_user_id, suggestion_id)
    Charles::TunesTakeoutWrapper.add_favorite(params["current_user_id"], params["suggestion_id"])
  end

  def unfavorite
  end
end
