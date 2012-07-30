require 'spec_helper'

describe Asana::Workspace do
  before do
    VCR.insert_cassette('workspaces', record: :new_episodes)
    authorize_with_asana
  end

  describe "Showing available workspaces" do
    specify do
      Asana::Workspace.all.first.should be_instance_of Asana::Workspace
    end
  end

  pending "Updating an existing workspace"
end
