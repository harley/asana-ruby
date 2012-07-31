require 'pry'

class Asana::Project < Asana::Resource
  alias :create :method_not_allowed
  alias :destroy :method_not_allowed

  def self.all_by_task(*args)
    parent_resources :task
    all(*args)
  end

  def self.all_by_workspace(*args)
    parent_resources :workspace
    all(*args)
  end

  def tasks
    get(:tasks).map{|h| Asana::Task.find h["id"]}
  end
end
