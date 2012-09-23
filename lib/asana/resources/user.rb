class Asana::User < Asana::Resource
  def self.me
    self.new(get(:me))
  end
end
