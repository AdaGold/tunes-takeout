require 'httparty'
module Charles
  class TunesTakeoutWrapper
    BASE_URL = "https://tunes-takeout-api.herokuapp.com"
    FAVS_URL = "https://tunes-takeout-api.herokuapp.com/v1/suggestions/top"
    attr_reader :suggestions
    def initialize(data)
      @suggestions = data

      #@food_id = data["suggestions"]["food_id"]
      # @music_id = data["suggestions"]["music_id"]
      # @music_type = data["suggestions"]["music_type"]


    end

    def self.find(user_input)
      #find the suggestions base on the user_input
      data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{user_input}/").parsed_response
      return self.new(data["suggestions"])
    end

    def self.all_favorites
      data = HTTParty.get('https://tunes-takeout-api.herokuapp.com/v1/suggestions/top').parsed_response
      total = data["suggestions"].map do |one_charles_id|
      HTTParty.get(BASE_URL + "/v1/suggestions/#{one_charles_id}").parsed_response
      end
      return self.new(total)
    end


  end
end
