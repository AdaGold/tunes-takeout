
class Food
  attr_reader :the_image_url, :rating, :name, :review_count, :rating_img_url_large, :categories, :location
  def initialize(data)
    @the_image_url = data.business.image_url
    @name = data.business.name
    @rating = data.business.rating
    @review_count = data.business.review_count
    @rating_img_url_large = data.business.rating_img_url_large
    @categories = data.business.categories
    @location = data.business.location.display_address
  end

  def self.find_in_api(id)
  data = Yelp.client.business(id)
  return self.new(data)
  end
end
