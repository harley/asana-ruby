require 'spec_helper'
require 'pry'

describe Asana::Task do
  before do
    VCR.insert_cassette('tasks', record: :all)
    authorize_with_asana
  end

  after do
    VCR.eject_cassette
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

  context "ActiveResource supported methods" do

    it "" do
      binding.pry
    end
  end
end
