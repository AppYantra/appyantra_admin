require 'spec_helper'

describe AppyantraAdmin::PasswordsController do

  let(:admin_user) { FactoryGirl.create(:admin) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create', { admin: { email: admin_user.email } }
      response.should be_redirect
      response.should redirect_to '/appyantra_admin/sign_in'
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', {reset_password_token: admin_user.reset_password_token }
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    it "returns http success" do
      put 'update', {admin: { password: 'admin123', password_confirmation: 'admin123', reset_password_token: admin_user.reset_password_token } }
      response.should be_success
    end
  end

end
