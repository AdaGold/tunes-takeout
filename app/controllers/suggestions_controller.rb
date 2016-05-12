class SuggestionsController < ApplicationController

  DEFAULT_SUGGESTION_SEARCH = "Ada"
  DEFAULT_SUGGESTION_COUNT = 10

  def index
    if !signed_in?
      return redirect_to login_path
    end

    @suggestions = Suggestion.find_random(params[:q] || DEFAULT_SUGGESTION_SEARCH,
                                          DEFAULT_SUGGESTION_COUNT)
  end

  def show
    @suggestion = Suggestion.find_by(id: params[:id])
    if @suggestion.nil?
      render file: 'public/404.html', status: :not_found
    end
  end
end
