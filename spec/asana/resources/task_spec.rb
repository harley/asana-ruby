require 'spec_helper'

describe Asana::Task do
  use_vcr_cassette
  before do
    authorize_with_asana
  end

  context "API" do
    context "creating a new task" do
      describe "POST /tasks" do
        it "should raise exception with incomplete data" do
          expect {Asana::Task.post('/', nil, "name='first time'")}.to raise_exception
        end
      end
    end
  end

  describe ".remove_project and .add_project" do
    let(:project) { Asana::Project.first }
    let(:task) { project.tasks.first }

    it "should work" do
      task.remove_project(project)
      project.tasks.should_not include task

      task.add_project(project)
      project.tasks.should include task
    end
  end

  describe ".add_tag and .remove_tag" do
    let(:tag)

  end
end
