class SpotifyItem < ActiveRecord::Base

  # Automatically build a new instance from attributes on an API object
  include BuildsFromAPI
  ATTRS_FROM_API = %w(item_id type name url image_url)
  ATTR_MAP = {
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
end
