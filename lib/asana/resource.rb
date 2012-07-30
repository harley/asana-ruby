module Asana
  class Resource < ActiveResource::Base
    def method_not_allowed
      raise ActiveResource::MethodNotAllowed.new(__method__)
    end

    # OVERRIDING
    class << self
      def remove_json_extension(url)
        url.gsub(/\.json/,'')
      end

      # override to remove .json extension in the URL
      def custom_method_collection_url(method_name, options = {})
        remove_json_extension super
      end

      def element_path(id, prefix_options = {}, query_options = nil)
        remove_json_extension super
      end

      def new_element_path(prefix_options = {})
        remove_json_extension super
      end

      def collection_path(prefix_options = {}, query_options = nil)
        remove_json_extension super
      end

      def singleton_path(prefix_options = {}, query_options = nil)
        remove_json_extension super
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
      self.class.remove_json_extension super
    end

    # override to remove .json extension in the URL
    def custom_method_new_element_url(method_name, options = {})
      self.class.remove_json_extension super
    end
  end
end
