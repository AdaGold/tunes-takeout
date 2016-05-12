module BuildsFromAPI
  extend ActiveSupport::Concern

  class_methods do

    # API data methods
    def find_or_create_by_api_data(data)
      api_attr_id = self::API_ATTR_ID
      existing = self.find_by(api_attr_id => api_attr_get(data, api_attr_id))
      return existing || self.create_from_api_data(data)
    end

    def new_from_api_data(data)
      return self.new do |obj|
        self::API_ATTR_LIST.map(&:to_sym).each do |attr|
          obj.send("#{attr}=".to_sym, api_attr_get(data, attr))
        end
      end
    end

    def create_from_api_data(data)
      obj = self.new_from_api_data(data)
      return obj.save ? obj : nil
    end


    # Utility methods
    def api_attr_map
      @attr_map ||= Hash.new { |hash, key| key }.merge(self::API_ATTR_MAP)
    end

    def api_attr_get(data, attr)
      mapped = api_attr_map[attr]
      return mapped.class == Proc ? mapped.call(data) : data.send(mapped)
    end
  end
end
