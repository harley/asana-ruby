require 'spec_helper'

module Asana
  describe Tag do
    describe "#tasks" do
      let(:tag) { Tag.new }

      before do
        Asana.configure do |nothing|
        end

        tag.stub(:id).and_return("1234")
      end

      it "should get the info from /tags/<tag id>/tasks" do
        fake_response = double("response", body: "{}")
        fake_connection = double("ActiveResource::Connection")
        expect(fake_connection).to receive(:get).with("/api/1.0/tags/1234/tasks", anything()).and_return(fake_response)
        expect(tag).to receive(:connection).and_return(fake_connection)
        tag.tasks
      end
    end
  end
end
