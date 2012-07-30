require 'spec_helper'
require 'pry'

describe Asana::Workspace do
  before do
    VCR.insert_cassette('workspaces', record: :new_episodes)
    authorize_with_asana
  end

  after do
    VCR.eject_cassette
  end

  let(:workspace) { Asana::Workspace.first }

  describe "Showing available workspaces" do
    specify do
      #binding.pry
      Asana::Workspace.all.first.should be_instance_of Asana::Workspace
    end
  end

  describe "Updating an existing workspace (name only)" do
    specify do
      old_name = workspace.name
      #expect {workspace.update_attribute :name, 'foobar'}.to change{workspace.name}.from(old_name).to('foobar')
    end
  end

  describe ".create_task" do
    specify do
      task = workspace.create_task(name: "test .create_task")
      task.should be_instance_of Asana::Task
      task.name.should == "test .create_task"
    end
  end
end
