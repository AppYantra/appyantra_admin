require 'spec_helper'

describe AppyantraAdmin::AssetsController do

  login_admin

  let(:product_asset) { FactoryGirl.build(:product) }
  let(:product_asset2) { FactoryGirl.create(:product) }
  let(:asset_name) { 'Product'}

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', { asset_name: 'Product'}
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', { asset_name: 'Product'}
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "returns http success" do
      post 'create', { asset_name: asset_name}
      asset_object = assigns(:asset_object)
      response.should be_redirect
      response.should redirect_to "/appyantra_admin/assets/#{asset_name}/#{asset_object.id}/show"
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', { asset_name: 'Product', id: product_asset2.id  }
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    it "returns http success" do
      put 'update', { asset_name: asset_name, id: product_asset2.id, product: product_asset2.attributes }
      asset_object = assigns(:asset_object)
      response.should be_redirect
      response.should redirect_to "/appyantra_admin/assets/#{asset_name}/#{asset_object.id}/show"
    end
  end

  describe "GET 'display'" do
    it "returns http success" do
      pending 'JS test case for display asset'
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', { asset_name: 'Product', id: product_asset2.id  }
      response.should be_redirect
      response.should redirect_to "/appyantra_admin/assets/#{asset_name}"
    end
  end

end
