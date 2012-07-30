require 'pry'
class Asana::Workspace < Asana::Resource
  def create_task(options = {})
    options.merge!(assignee: 'me') unless options[:assignee] or options['assignee']

    post_body = { data: options }
    response = post("tasks", nil, post_body.to_json)
    Asana::Task.new(connection.format.decode(response.body))
  rescue Exception => e
    $stderr.puts "ERROR: #{e.message}"
    $stderr.puts "RESPONSE: #{e.response.body}" if e.respond_to?(:response)
  end
end
