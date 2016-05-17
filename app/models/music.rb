require 'rspotify'
# require_relative '../lib/TunesTakeoutWrapper.rb'
require "#{Rails.root}/lib/TunesTakeoutWrapper.rb"

class Music

@all_suggestions.suggestion.map do |suggestion|
  if suggestion["music_type"] == "artist"
    artist = RSpotify::Artist.find(suggestion["music_id"])
  elsif suggestion["music_type"] == "album"
    album = RSpotify::Album.find(suggestion["music_id"])
  else
    track = RSpotify::Track.find(suggestion["music_id"])
end
#built in methods
# artist.related_artists #=> (Artist array)
# album.album_type #=> "single"
# track.album #=> (Album object)


end
