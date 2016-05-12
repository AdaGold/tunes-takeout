class Suggestion < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :spotify_item

  def self.new_from_api_data(business, spotify_item)
    return Suggestion.new do |suggestion|
      suggestion.restaurant = Restaurant.new_from_api_data(business)
      suggestion.spotify_item = SpotifyItem.new_from_api_data(item)
    end
  end
end
