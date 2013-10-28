require 'spec_helper'

module Asana
  describe Workspace, vcr: true do
    before do
      authorize_with_asana
    end

    let(:workspace) { Asana::Workspace.first }

    describe "Showing available workspaces" do
      specify do
        #binding.pry
        Asana::Workspace.all.first.should be_instance_of Asana::Workspace
      end
    end

    pending "Updating an existing workspace (name only)"

    describe ".create_task" do
      specify do
        task = workspace.create_task(name: "test .create_task")
        task.should be_instance_of Asana::Task
        task.name.should == "test .create_task"
      end
    end

    describe ".create_tag" do
      let(:tag_name) { "tag #{Date.today}" }
      subject { workspace.create_tag(name: tag_name)}

      it { should be_instance_of Asana::Tag}
      its(:name) { should == tag_name }
    end

    describe ".tasks" do
      subject { workspace }
      its(:tasks) { should be_instance_of Array }
      it "should return task instances" do
        workspace.tasks.first.should be_instance_of Task
      end
    end

    describe "tags" do
      subject { workspace }
      its(:tags) { should be_instance_of Array }
      it "should return task instances" do
        workspace.tags.first.should be_instance_of Tag
      end
    end

    describe ".find_or_create_tag" do
      let(:fake_tag) { double("Asana::Tag", name: "Test") }

      before do
        expect(workspace).to receive(:tags).and_return([fake_tag])
      end

      it "should not create two tags of the same name" do
        test_tag = workspace.find_or_create_tag(name: "Test")
        expect(test_tag).to be(fake_tag)
      end

      it "should create a tag that doesn't yet exist" do
        new_tag = workspace.find_or_create_tag(name: "Nope")
        expect(new_tag).to be_instance_of(Asana::Tag)
      end
    end
  end
end
