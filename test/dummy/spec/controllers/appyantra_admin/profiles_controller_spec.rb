require 'spec_helper'

describe AppyantraAdmin::ProfilesController do

  let(:admin_user1) { Factory.create(:admin, email: 'admin1@appyantra.com') }
  let(:admin_user2) { Factory.create(:admin, email: 'admin2@appyantra.com') }
  let(:admin_user3) { Factory.create(:admin, email: 'admin3@appyantra.com') }
  let(:admin_user_attrs) { { first_name: 'Tony', last_name: 'Stark', email: 'tony.stark@appyantra.com' }  }
  let(:new_admin_password) { { password: 'admin567', password_confirmation: 'admin567' }}
  let(:admin_user_obj) { Factory.build(:admin, email: 'admin4@appyantra.com' ) }

  context "Admin user is signed in" do

    login_admin

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        assigns(:admin_users).should eq(Admin.all)
        response.should be_success
      end
    end

    describe "GET 'show'" do
      it "returns http success" do
        get 'show', { id: admin_user1.id }
        assigns(:selected_admin_user).should eq(admin_user1)
        response.should be_success
      end
    end

    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        assigns(:admin_user).should be
        response.should be_success
      end
    end

    describe "POST 'create'" do
      it "returns http success" do
        post 'create', { admin_user: admin_user_obj.attributes }
        response.should be_redirect
        response.should redirect_to '/appyantra_admin/profiles'
        Admin.find_by_email(admin_user_obj.email).should be
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', { id: admin_user1.id }
        assigns(:admin_user).should eq(Admin.find(admin_user1.id))
        response.should be_success
      end
    end

    describe "PUT 'update'" do
      it "returns http success" do
        put 'update', { id: admin_user1.id , admin_user: admin_user_attrs }
        response.should be_redirect
        response.should redirect_to '/appyantra_admin/profiles'
        admin_user = Admin.find(admin_user1.id)
        admin_user.first_name.should eq(admin_user_attrs[:first_name])
        admin_user.last_name.should eq(admin_user_attrs[:last_name])
        admin_user.email.should eq(admin_user_attrs[:email])
      end
    end

    describe "DELETE 'destroy'" do
      it "returns http success" do
        delete 'destroy', { id: admin_user2.id }
        response.should be_redirect
        response.should redirect_to '/appyantra_admin/profiles'
        Admin.exists?(admin_user2.id).should be_false
      end
    end

    describe "PUT 'update_password'" do
      it "returns http success" do
        put 'update_password', { id: admin_user3.id, admin_user: new_admin_password }
        response.should be_redirect
        response.should redirect_to '/appyantra_admin/profiles'
        pending 'test password change'
      end
    end
  end

end
