# require 'rspotify '

class Music
  attr_reader :item_id, :type, :name, :open_spotify_url, :image, :uri
  def initialize(data)
    @item_id = data.id
    @type	= data.type
    @name	= data.name
    @open_spotify_url = data.external_urls["spotify"]
     if data.type == "track"
       @image = data.album.images[1]["url"]
     elsif data.type == "artist"
       @image = data.albums[0].images[1]["url"]
     else
       @image = data.images[1]["url"]
     end
    @uri = data.uri
  end

  def self.create(type, id)
    if type == "artist"
        music_result = RSpotify::Artist.find(id)
      elsif type == "album"
        music_result = RSpotify::Album.find(id)
      else
        music_result = RSpotify::Track.find(id)
      end
    return self.new(music_result)
  end

end
