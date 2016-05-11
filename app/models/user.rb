class User < ActiveRecord::Base

  def self.find_or_create_by_auth_hash(auth_hash)
    raise ArgumentError.new("Auth hash does not contain OAuth UID") unless auth_hash[:uid]

    user = User.find_or_create_by(oauth_provider: default_provider, oauth_uid: auth_hash[:uid])

    # Use the OAuth data to setup or update our Spotify User
    user.instance_eval { spotify_data = auth_hash } # ugh
    return user.save ? user : nil
  end

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

  def self.default_provider
    'spotify'
  end
end
