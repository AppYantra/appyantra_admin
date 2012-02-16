module AppyantraAdmin
  class ProfilesController < ApplicationController

    include AppyantraAdmin::Utils
    
    before_filter :authenticate_admin!
    
    # breadcrumbs
    before_filter(only: [:index, :new, :edit, :show]) { |c| c.add_breadcrumb(['Home', main_app.appyantra_admin_home_url])}
    before_filter(only: [:new, :edit, :show]) { |c| c.add_breadcrumb(['Admin Profiles', main_app.admin_profiles_url])}
    
    def index
      @page_title = 'Admin Profiles'
      current_breadcrumb @page_title
    	@admin_users = Admin.all
      render 'index'
    end
    
    def new
      @page_title = 'New Admin User'
      current_breadcrumb 'New'
      @admin_user = Admin.new
    end
    
    def create
      selected_admin_user = Admin.new(params[:admin_user])
      # TODO random password
      password = random_password
      selected_admin_user.password = password
      selected_admin_user.password_confirmation = password
      respond_to do |format|
        if selected_admin_user.save
          format.html do |format|
            flash[:notice] = "Admin user was successfully created" 
            redirect_to main_app.admin_profiles_path
          end
        else
          # TODO handle errors
        end
      end  
    end
  
    def show
      @selected_admin_user = Admin.find(params[:id])
      @page_title = 'Admin User | ' + @selected_admin_user.display_name
      current_breadcrumb @selected_admin_user.display_name
      respond_to do |format|
        format.html
        format.js
      end	
    end
  
    def edit
      @admin_user = Admin.find(params[:id])
      @page_title = 'Admin User | ' + @admin_user.display_name
      add_breadcrumb([@admin_user.display_name, main_app.admin_profile_url(@admin_user)])
      current_breadcrumb 'Edit'
      render 'edit'
    end
  
    def update
    	selected_admin_user = Admin.find(params[:id])
      respond_to do |format|
        if selected_admin_user.update_attributes(params[:admin_user])
          format.html do |format|
            flash[:notice] = "Profile was successfully updated." 
            redirect_to main_app.admin_profiles_path
          end
        else
          # TODO handle errors
        end
      end
    end
    
    def update_password
      admin_user = Admin.find(params[:id])
      password_params = params[:admin_user]
      admin_user.reset_password!(password_params[:password], password_params[:password_confirmation])
      # TODO Fix auto logout issue when password is changed
      sign_in(current_admin, :bypass => true)
      flash[:notice] = "Password was successfully updated."
      redirect_to main_app.admin_profiles_path
      # TODO handle errors
    end
    
    def destroy
      admin_user = Admin.find(params[:id])
      admin_user.destroy
      flash[:notice] = "Admin was successfully deleted."
      redirect_to main_app.admin_profiles_path
    end
  
  end
end
