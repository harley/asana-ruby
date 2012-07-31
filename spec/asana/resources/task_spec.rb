require 'spec_helper'
require 'pry'

describe Asana::Task do
  use_vcr_cassette
  before do
    authorize_with_asana
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
end
