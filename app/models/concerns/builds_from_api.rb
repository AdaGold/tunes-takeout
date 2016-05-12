module BuildsFromAPI
  extend ActiveSupport::Concern

  class_methods do

    def new_from_api(api_data)
      return self.new do |obj|
        self::API_ATTR_LIST.map(&:to_sym).each do |attr|
          obj.send("#{attr}=".to_sym, api_attr_get(api_data, attr))
        end
      end
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
