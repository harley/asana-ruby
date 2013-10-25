require 'spec_helper'

module Asana
  describe Workspace do
    use_vcr_cassette
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

    describe "tags" do
      subject { workspace }
      its(:tags) { should be_instance_of Array }
      it "should return task instances" do
        workspace.tags.first.should be_instance_of Tag
      end
    end

    describe ".find_or_create_tag" do
      it "should not create two tags of the same name" do
        tag1 = workspace.find_or_create_tag(name: 'test .find_or_create_tag')
        tag2 = workspace.find_or_create_tag(name: 'test .find_or_create_tag')
        tag1.id.should == tag2.id
      end

      it "should only create tag account by one" do
        expect { 3.times { workspace.find_or_create_tag(name: '3 times') } }.to change { workspace.tags.size }.by(1)
      end
    end
  end
end
