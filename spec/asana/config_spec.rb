require 'spec_helper'

describe "Asana::Config" do
  it "should set configuration correctly" do
    Asana.configure do |c|
      c.api_key = "SOME API KEY"
    end

    Asana::Resource.user.should == "SOME API KEY"
  end
end
