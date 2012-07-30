require 'active_resource'

require 'asana/version'
require 'asana/config'

require 'asana/resource'
require 'asana/resources/user'
require 'asana/resources/workspace'
require 'asana/resources/task'

module Asana
  # Your code goes here...
  extend Config
  def self.default_workspace
    Asana::Workspace.first
  end
end
