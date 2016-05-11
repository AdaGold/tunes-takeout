class Restaurant < ActiveRecord::Base

  # Automatically build a new instance from attributes on an API object
  include BuildsFromAPI
  ATTRS_FROM_API = %w(business_id name url image_url phone rating)
  ATTR_MAP = {business_id: :id, phone: :display_phone}
end
