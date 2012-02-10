require 'spec_helper'

describe AppyantraAdmin::HomeController do

  context "Admin user is signed in" do

    login_admin

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        assigns(:assets).should eq(AppyantraAdmin.assets)
        response.should be_success
      end
    end
  end

  context "Admin user not signed in" do
    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_redirect
        response.should redirect_to '/appyantra_admin/sign_in'
      end
    end
  end

end
