require "#{Rails.root}/lib/charles/TunesTakeoutWrapper.rb"
require "#{Rails.root}/app/models/music.rb"
require 'rspotify'

class SuggestionsController < ApplicationController
  def index
  end

  def result
    @all_suggestions = Charles::TunesTakeoutWrapper.find(params[:user_input])
    #an array id
    @music = @all_suggestions.suggestions.map do |sugg_hash|
      Music.create(sugg_hash["music_type"], sugg_hash["music_id"])
    end

    # @food = @all_suggestions.suggestions.map do |sugg_hash|
    #   Food.create(sugg_hash)
    # end

  end

  def favorite
  end

  def favorites
  end

  def unfavorite
  end
end
