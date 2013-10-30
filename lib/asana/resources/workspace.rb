module Asana
  class Workspace < Asana::Resource
    def create_task(options = {})
      # options.merge!(assignee: 'me') unless options[:assignee] or options['assignee']
      options.merge!(workspace: self.id)

      post_body = { data: options }
      response = Task.post(nil, nil, post_body.to_json)
      hash = connection.format.decode(response.body)

      # want to return a persisted record
      Task.find hash["id"]
    rescue Exception => e
      $stderr.puts "ERROR: #{e.message}"
      $stderr.puts "RESPONSE: #{e.response.body}" if e.respond_to?(:response)
    end

    # From API docs: If you specify a workspace you must also specify an assignee to filter on.
    def tasks(options = {})
      options.merge!(assignee: 'me') unless options[:assignee] or options['assignee']

      url = "tasks?assignee=#{options[:assignee]}"

      url += "&include_archived=true" if options[:include_archived]

      get(url).map { |h| Asana::Task.find h["id"] }
    rescue Exception => e
      $stderr.puts "ERROR: #{e.message}"
      $stderr.puts "RESPONSE: #{e.response.body}" if e.respond_to?(:response)
    end

    def completed_tasks
      tasks.select(&:completed?)
    end

    # TODO imporve this when Asana API is more advanced
    def find_or_create_tag(options = {})
      options[:name].strip! if options[:name]

      # try to load from cache first, if not found, force reload, if still not found, create one
      find_tag_from_list(tags, options) || find_tag_from_list(tags(true), options) || create_tag(options)
    end

    def create_tag(options = {})
      response = post("tags", nil, {data: options}.to_json)
      Asana::Tag.new(connection.format.decode(response.body), true)
    end

    # Resource.new(record, true) is the trick to initialize a persisted record
    def tags(force_reload = false)
      return @tags if defined?(@tags) and !force_reload
      @tags ||= get(:tags).map{|h| Asana::Tag.new(h, true)}
    end

    # expensive query: reload each task by id
    # only use this if Asana::Tag.new(tag, true) doesn't work as expected
    def load_tags_by_id
      get(:tags).map{|h| Asana::Tag.find h["id"]}
    end

    def find_tag_from_list(tag_list, options = {})
      tag_list.find {|t| t.name && options[:name] && t.name.strip == options[:name] }
    end
  end
end
