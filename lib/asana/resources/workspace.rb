require 'pry'
class Asana::Workspace < Asana::Resource
  def create_task(*args)
    options = { :assignee => 'me' }
    post_body = {data: options.merge(args.first)}
    response = post("tasks", nil, post_body.to_json)
    Asana::Task.new(connection.format.decode(response.body))
  end
end
