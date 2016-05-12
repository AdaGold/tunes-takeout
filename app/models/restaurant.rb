class Restaurant < ActiveRecord::Base

  # Automatically build a new instance from attributes on an API object
  include BuildsFromAPI
  API_ATTR_ID = :business_id
  API_ATTR_LIST = %w(business_id name url image_url phone rating)
  API_ATTR_MAP = {business_id: :id, phone: :display_phone}

  DEFAULT_YELP_LOCATION = 'Seattle'
  DEFAULT_YELP_PARAMS = { category: 'food' }

  def self.new_from_api_id(business_id)
    self.new_from_api(Yelp.client.business(business_id))
  end

  def self.search(query, limit)
    params = DEFAULT_YELP_PARAMS.merge(term: query, limit: limit)
    resp = Yelp.client.search(DEFAULT_YELP_LOCATION, params)
    return resp&.businesses || []
  end
end
