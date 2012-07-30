require 'spec_helper'

module Asana
  describe User do
    before do
      Asana.configure do |c|
        c.api_key = 'nSZfywi.U8aR4lxeTJBkYgK84Ton0UNp'
      end
    end

    describe '.me' do
      specify do
        user = User.me
        user.should_not be_nil
        user.should be_instance_of User
      end
    end
  end
end
