require 'pry'
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
      cached_tags.find {|t| t.name && options[:name] && t.name.strip == options[:name].strip } ||
        tags.find {|t| t.name && options[:name] && t.name.strip == options[:name].strip } ||
          create_tag(options)
    end

    def create_tag(options = {})
      response = post("tags", nil, {data: options}.to_json)
      Asana::Tag.new(connection.format.decode(response.body), true)
    end

    def tags
      @cached_tags = get(:tags).map{|h| Asana::Tag.new(h, true)}
    end

    def add_to_cached(tag)
      @cached_tags ||= []
      @cached_tags << tag
    end

    def cached_tags
      if @cached_tags
        @cached_tags
      else
        tags
      end
    end
  end
end
