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

  # Find/Build methods
  def self.find_random(query, limit)
    restaurants = Restaurant.search(query, limit).shuffle
    spotify_items = SpotifyItem.search(query, limit).shuffle
    num_pairs = [restaurants.length, spotify_items.length].min

    # We'll just do single pairs for now, rather than cartesian product
    (0...num_pairs).map do |n|
      self.new_from_api_data(restaurants[n], spotify_items[n])
    end
  end
end
