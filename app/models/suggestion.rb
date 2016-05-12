class Suggestion < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :spotify_item


  # API data methods
  def self.new_from_api_data(business, spotify_item)
    return Suggestion.new do |suggestion|
      suggestion.restaurant = Restaurant.find_or_create_by_api_data(business)
      suggestion.spotify_item = SpotifyItem.find_or_create_by_api_data(spotify_item)
    end
  end

  def self.create_from_api_data(business, spotify_item)
    suggestion = self.new_from_api_data(business, spotify_item)
    return suggestion.save ? suggestion : nil
  end


  # API id methods
  def self.new_from_api_id(business_id, item_id)
    return Suggestion.new do |suggestion|
      suggestion.restaurant = Restaurant.find_or_create_by_api_id(business_id)
      suggestion.spotify_item = SpotifyItem.find_or_create_by_api_id(item_id)
    end
  end

  def self.create_from_api_id(business_id, item_id)
    suggestion = self.new_from_api_id(business_id, item_id)
    return suggestion.save ? suggestion : nil
  end
end
