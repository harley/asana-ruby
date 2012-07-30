require 'asana'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
end

def authorize_with_asana
  Asana.configure do |c|
    c.api_key = 'nSZfywi.U8aR4lxeTJBkYgK84Ton0UNp'
  end
end

TEST_WORKSPACE_ID = '1356785960235'
