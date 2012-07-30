require 'spec_helper'

module Asana
  describe User do
    before do
      VCR.insert_cassette('users', record: :new_episodes)
      authorize_with_asana
    end

    after do
      VCR.eject_cassette
    end

    describe "showing a single user" do
      describe '.me' do
        specify do
          user = User.me
          user.should_not be_nil
          user.should be_instance_of User
        end
      end

      pending "GET /users/user-id"
    end

    pending "showing all users in all workspaces"
    pending "showing all users in a single workspace"
  end
end
