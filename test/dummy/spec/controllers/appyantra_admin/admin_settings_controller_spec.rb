require 'spec_helper'

describe AppyantraAdmin::AdminSettingsController do

  login_admin

  let(:website_link) { FactoryGirl.build(:link) }
  let(:website_link2) { FactoryGirl.create(:link) }
  let(:website_link_setting) { FactoryGirl.create(:admin_setting, entity_type: 'Link', entity_id: website_link2.id) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', {setting_name: 'website_url', entity_type: 'Link'}
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create', { setting_name: 'website_url', entity_type: 'Link', link: website_link.attributes, group: 'General' }
      response.should be_redirect
      response.should redirect_to '/appyantra_admin/settings'
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', {id: website_link_setting.id, link: website_link.attributes }
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    it "returns http success" do
      put 'update', {id: website_link_setting.id}
      response.should be_redirect
      response.should redirect_to '/appyantra_admin/settings'
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', {id: website_link_setting.id}
      response.should be_redirect
      response.should redirect_to '/appyantra_admin/settings'
    end
  end

end
