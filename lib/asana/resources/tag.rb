class Asana::Tag < Asana::Resource
  def tasks
    get(:tasks)
  end
end
