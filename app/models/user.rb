class User < ActiveRecord::Base
  validates :uid, :provider, presence: true
  #:name

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user

    user = self.find_by(uid: auth_hash["info"]["id"], provider: auth_hash["provider"])
    if !user.nil?
      return user
    else
      user = User.new
      if auth_hash["info"]["images"] == []
        user.uid = auth_hash["info"]["id"]
        user.images = "http://i1.wp.com/www.techrepublic.com/bundles/techrepubliccore/images/icons/standard/icon-user-default.png"
      else
        user.uid = auth_hash["uid"]
        user.name = auth_hash["info"]["display_name"]
        user.images = auth_hash["info"]["images"][0]["url"]
      end
      user.open_spotify_url = auth_hash["info"]["external_urls"]["spotify"]
      user.provider = auth_hash["provider"]

      if user.save
        return user
      else
        return nil
      end
    end
  end
end
