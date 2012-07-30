module Asana
  class Resource < ActiveResource::Base
    def method_not_allowed
      raise ActiveResource::MethodNotAllowed.new(__method__)
    end

    # OVERRIDING
    class << self
      # override to remove .json extension in the URL
      def custom_method_collection_url(method_name, options = {})
        url = super
        url.gsub(/\.json/,'')
      end
    end

    # Asana wants it to be nested under data
    def to_json(options={})
      ret = super({ :root => 'data' }.merge(options))
      puts "CONVERTING: #{options} TO: #{ret}"
      ret
    end

    private
    # override to remove .json extension in the URL
    def custom_method_element_url(method_name, options = {})
      url = super
      url.gsub(/\.json/,'')
    end

    # override to remove .json extension in the URL
    def custom_method_new_element_url(method_name, options = {})
      url = super
      url.gsub(/\.json/,'')
    end
  end
end
