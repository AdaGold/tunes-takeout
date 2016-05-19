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
      user.uid = auth_hash["info"]["id"]
      user.provider = auth_hash["provider"]
      user.images = auth_hash["info"]["images"].first
      if user.save
        return user
      else
        return nil
      end
    end
  end
end
