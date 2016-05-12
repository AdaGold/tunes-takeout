module BuildsFromAPI
  extend ActiveSupport::Concern

  class_methods do
    def new_from_api(api_data)
      return self.new do |obj|
        attr_map = Hash.new { |hash, key| key }.merge(self::API_ATTR_MAP)

        self::API_ATTR_LIST.map(&:to_sym).each do |attr|
          mapped = attr_map[attr]
          value = mapped.class == Proc ? mapped.call(api_data) : api_data.send(mapped)

          obj.send("#{attr}=".to_sym, value)
        end
      end
    end
  end
end
