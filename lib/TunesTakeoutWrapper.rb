require 'httparty'
class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
  attr_reader :food_id, :music_id, :music_type
  def initialize(data)
    @suggestions = data["suggestions"]#["food_id"]
    # @music_id = data["suggestions"]["music_id"]
    # @music_type = data["suggestions"]["music_type"]
  end

  def self.find(id)
    #find the suggestions base on the user_input
    data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{user_input}/").parsed_response
    return self.new(data)
  end


end
