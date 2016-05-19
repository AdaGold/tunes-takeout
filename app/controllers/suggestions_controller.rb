require "#{Rails.root}/lib/charles/TunesTakeoutWrapper.rb"
require "#{Rails.root}/app/models/music.rb"
require 'rspotify'

class SuggestionsController < ApplicationController
  def index
  end

  def result
    @all_suggestions = Charles::TunesTakeoutWrapper.find(params[:user_input])

    if @all_suggestions.suggestions.nil?

      flash.now[:notice] = "Something went wrong, please try again"
      render :index

    else

      @music = @all_suggestions.suggestions.map do |sugg_hash|
        Music.create(sugg_hash["music_type"], sugg_hash["music_id"])
      end

      @food = @all_suggestions.suggestions.map do |sugg_hash|
        Food.find_in_api(sugg_hash["food_id"])
      end

      @zip = @music.zip @food

    end
  end

  def favorite
  end

  def favorites
  end

  def unfavorite
  end
end
