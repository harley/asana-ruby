require 'asana/resource'
require 'asana/version'

module Asana
  module Config
    API_VERSION = '1.0'
    DEFAULT_ENDPOINT = "https://app.asana.com/api/#{API_VERSION}/"
    USER_AGENT = "Asana Ruby Gem #{Asana::VERSION}"

    attr_accessor :api_key
    def configure
      yield self
      Resource.user = self.api_key
      Resource.password  = ''
      Resource.format    = :json
      Resource.site = DEFAULT_ENDPOINT
    end
  end
end
