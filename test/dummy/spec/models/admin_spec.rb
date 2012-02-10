require 'spec_helper'

describe Admin do

  let(:admin_user) { Factory.create(:admin, first_name: 'Eric', last_name: 'Cartman' ) }

  it "should return a display name" do
    admin_user.display_name.should eq admin_user.first_name + ' ' + admin_user.last_name
  end
end
