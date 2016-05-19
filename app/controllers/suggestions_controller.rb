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
        uri = Addressable::URI.parse(sugg_hash["food_id"])
        Food.find_in_api(uri.normalize.to_s)
      end

      @zip = @music.zip @food

    end
    render :index
  end

  
  def favorite
  end

  def favorites
  end

  def unfavorite
  end
end
