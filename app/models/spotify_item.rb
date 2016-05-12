class SpotifyItem < ActiveRecord::Base

  # Automatically build a new instance from attributes on an API object
  include BuildsFromAPI
  API_ATTR_ID = :item_id
  API_ATTR_LIST = %w(item_id type name url image_url)
  API_ATTR_MAP = {
    item_id: :id,
    url: ->(item) {
      item.external_urls["spotify"]
    },
    image_url: ->(item) {
      case item.type
      when "album" || "artist" || "playlist"
        item.images[0]["url"]
      when "track"
        item.album.images[0]["url"]
      end
    }
  }

  def self.new_from_api_id(item_id)
    self.new_from_api_data(DEFAULT_SPOTIFY_TYPE.find(item_id))
  end
end
