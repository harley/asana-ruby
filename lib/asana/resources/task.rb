module Asana
  class Task < Asana::Resource
    # don't want update_attribute because it posts all data to asana instead of just changed attributes
    alias :update_attribute :method_not_allowed
    # create a task via a project or workspace instead
    alias :create :method_not_allowed

    def add_project(project)
      project = project.id if project.is_a?(Project)
      post('addProject', nil, {data: {project: project}}.to_json)
    end

    def remove_project(project)
      project = project.id if project.is_a?(Project)
      post('removeProject', nil, {data: {project: project}}.to_json)
    end
  end
end
