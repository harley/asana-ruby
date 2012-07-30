require 'spec_helper'
require 'pry'

describe Asana::Task do
  before do
    VCR.insert_cassette('tasks', record: :new_episodes)
    authorize_with_asana
  end

  context "creating a new text" do
    describe "POST /tasks" do
      it "should raise exception with incomplete data" do
        expect {Asana::Task.post('/', nil, "name='first time'")}.to raise_exception
      end
    end
  end
end
