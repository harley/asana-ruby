class Asana::Task < Asana::Resource
  # don't want update_attribute because it posts all data to asana instead of just changed attributes
  alias :update_attribute :method_not_allowed
  # create a task via a project or workspace instead
  alias :create :method_not_allowed
end
