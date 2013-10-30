require 'asana'
require 'webmock/rspec'
require 'vcr'
require 'active_resource'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

def authorize_with_asana
  Asana.configure do |c|
    c.api_key = 'nSZfywi.U8aR4lxeTJBkYgK84Ton0UNp'
  end
end

TEST_WORKSPACE_ID = '1356785960235'

class ActiveResource::Connection
  def http
    ret = configure_http(new_http)
    ret.set_debug_output $stderr
    ret
  end
end
