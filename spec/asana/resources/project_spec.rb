require 'spec_helper'

module Asana
  describe Project do
    before do
      VCR.insert_cassette('tasks', record: :all)
      authorize_with_asana
    end

    after do
      VCR.eject_cassette
    end

    describe '.all' do
      it 'should return all of the user\'s projects' do
        projects = Project.all
        projects.should be_instance_of Array
        projects.first.should be_instance_of Project
      end
    end

    describe '.create' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        project = Project.new
        lambda { project.save }.should raise_error(ActiveResource::MethodNotAllowed)
      end
    end

    describe '.find' do
      it 'should return a single project' do
        project = Project.find(Project.all.first.id)
        project.should be_instance_of Project
      end
    end

    describe '#destroy' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        project = Project.all.first
        lambda { project.destroy}.should raise_error ActiveResource::MethodNotAllowed
      end
    end

    describe '#tasks' do
      it 'should return all tasks for the given project' do
        projects = Project.all.first
        tasks = projects.tasks
        tasks.should be_instance_of Array
      end
    end
  end
end
