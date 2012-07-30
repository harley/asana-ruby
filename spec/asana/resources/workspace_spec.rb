require 'spec_helper'

describe Asana::Workspace do
  before do
    VCR.insert_cassette('workspaces', record: :new_episodes)
    authorize_with_asana
  end

  after do
    VCR.eject_cassette
  end

  describe "Showing available workspaces" do
    specify do
      Asana::Workspace.all.first.should be_instance_of Asana::Workspace
    end
  end

  describe "Updating an existing workspace (name only)" do
    specify do
      workspace = Asana::Workspace.first
      # TODO why update_attribute and save not working
    end
  end
end
