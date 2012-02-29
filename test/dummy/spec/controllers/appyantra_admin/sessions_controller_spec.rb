require 'spec_helper'

describe AppyantraAdmin::SessionsController do

  let(:admin_user) { FactoryGirl.build(:admin) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post :create, admin: admin_user.attributes
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy'
      response.should be_redirect
    end
  end

end
