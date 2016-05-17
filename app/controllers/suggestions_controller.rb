require "#{Rails.root}/lib/charles/TunesTakeoutWrapper.rb"

class SuggestionsController < ApplicationController
  def index
    # include tunes_takeout_wrapper

    @suggestions = Charles::TunesTakeoutWrapper.find(params[:user_input])
  end

  def favorite
  end

  def favorites
  end

  def unfavorite
  end
end
