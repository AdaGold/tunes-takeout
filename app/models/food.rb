
# require 'yelp'

class Food
  attr_reader :rating, :name
  def initialize(data)
    @name = data.business.name
    @rating = data.business.rating
    @review_count = data.business.review_count
    @rating_img_url_small = data.business.rating_img_url_small
    @categories = data.business.categories
    @location = data.business.location['display_address']
  end

  def self.find_in_api(id)
  data = Yelp.client.business(id)
  return self.new(data)
  end
end
