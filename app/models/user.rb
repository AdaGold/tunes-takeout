class User < ActiveRecord::Base

  def spotify_data
    # Initialize a Spotify User from previously persisted hash data
    @spotify_user ||= RSpotify::User.new(JSON.parse(super))
  end

  private

  def spotify_data=(hash)
    # Create a new Spotify User and persist its hash data (as JSON)
    @spotify_user = RSpotify::User.new(hash)
    write_attribute(:spotify_data, @spotify_user.to_hash.to_json)

    return @spotify_user
  end
end
