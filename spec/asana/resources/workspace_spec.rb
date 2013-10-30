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

      context "with include_archived set to true in options" do
        it "should pass the option as part of the query string for the API endpoint" do
          stub_request(:any, "app.asana.com")
          workspace.tasks(include_archived: true)

          to_url = %r{app.asana.com/api/1.0/workspaces/#{workspace.id}/tasks}
          a_request(:get, to_url).with(
            query: hash_including({include_archived: 'true'})
          ).should have_been_made
        end
      end
    end

    describe ".completed_tasks" do
      it "returns only completed tasks" do
        expect(workspace.completed_tasks.all?(&:completed)).to be
      end
    end

    describe "tags" do
      let(:fake_tag) { double("Asana::Tag", name: "Test") }

      subject { workspace }
      its(:tags) { should be_instance_of Array }
      it "should return task instances" do
        workspace.tags.first.should be_instance_of Tag
      end

      it "should memoize tags" do
        expect(Asana::Tag).to receive(:new).and_return(fake_tag)
        Asana::Tag.stub(:new).and_return(fake_tag)
        expect(workspace).to receive(:get).once.and_return([fake_tag])
        workspace.tags # first time
        workspace.tags # second time
      end

      it "should return the same result with force_reload (if no changes)" do
        expect(workspace.tags.size).to be > 0 # it'd be meaningless to compare if there are no tags
        expect(workspace.tags).to eq workspace.tags(true)
      end
    end

    describe ".find_or_create_tag" do
      let(:fake_tag) { double("Asana::Tag", name: "Test") }

      before do
        expect(workspace).to receive(:tags).at_least(:once).and_return([fake_tag])
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
