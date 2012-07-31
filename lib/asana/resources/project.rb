class Asana::Project < Asana::Resource
  alias :create :method_not_allowed
  alias :destroy :method_not_allowed

  def tasks
    get(:tasks).map{|h| Asana::Task.find h["id"]}
  end
end
