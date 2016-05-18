
class Music
  attr_reader :item_id, :type, :name, :url, :images
  def initialize(data)
    @item_id = data.id
    @type	= data.type
    @name	= data.name
    @open_spotify_url = data.external_urls["spotify"]
     if data.type == "track"
       @images = data.album.images
     else
       @images = data.images
     end
  end

  def self.create(type, id)
    if type == "artist"
        music_result = RSpotify::Artist.find(id)
      elsif type == "album"
        music_result = RSpotify::Album.find(id)
      elsif type == "playlist"
        # music_result = RSpotify::Playlist.find(id)
        music_result = RSpotify::Artist.find("1Xb0GGagoN5fWgMYOzlnzc")
      else
        music_result = RSpotify::Track.find(id)
      end
      return self.new(music_result)

  end



  # def self.get_music(music_id)
  #   music_suggestion = RSpotify::Artist.find(music_id)
  # end
  #
  # def get_type(type)
  #
  #
  #
  #   end

end
