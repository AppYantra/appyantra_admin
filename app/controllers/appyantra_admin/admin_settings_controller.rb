module AppyantraAdmin
	class AdminSettingsController < ApplicationController
    
    before_filter :authenticate_admin!
    before_filter :init_type, only: [:create, :new]
    # breadcrumbs
    before_filter(only: [:index, :new, :edit]) { |c| c.add_breadcrumb(['Home', main_app.appyantra_admin_home_url])}
    before_filter(only: [:new, :edit]) { |c| c.add_breadcrumb(['Settings', main_app.settings_url])}
    
    def index
      @page_title = 'Settings'
      current_breadcrumb @page_title
      @settings = AdminSetting.all
    end
    
    def new
      @page_title = 'New'
      current_breadcrumb @page_title
      @entity_object = @type_class.new
    end
    
    def create
      type_object_name = get_object_name @type_class
      type_object = @type_class.new(params[type_object_name.to_sym])  
      # TODO set name as slug  
      AdminSetting.create({ name: @setting_name, display_name: @setting_name, entity_type: @entity_type, entity_id: type_object.id }) if type_object.save #TODO error handling    
  
      respond_to do |format|
        format.html do |format|
          flash[:notice] = "Setting was successfully added." 
          redirect_to main_app.settings_path
        end
      end
    end
    
    def update
      setting = AdminSetting.find(params[:id])
      type_object_name = get_object_name setting.entity.class
      respond_to do |format|
        if setting.entity.update_attributes(params[type_object_name.to_sym])
          format.html do |format|
            flash[:notice] = "Setting was successfully updated." 
            redirect_to main_app.settings_path
          end
        else
          # TODO handle errors
        end
      end
    end
    
    def destroy
      setting = AdminSetting.find(params[:id])
      # TODO error handling
      setting.entity.destroy
      setting.destroy
  
      respond_to do |format|
        format.html do |format|
          flash[:notice] = "Setting was successfully removed." 
          redirect_to main_app.settings_path
        end
      end
    end
    
    def edit
      @page_title = 'Edit'
      current_breadcrumb @page_title
      @setting = AdminSetting.find(params[:id])
    end
    
    private
    
    def init_type
      @setting_name = params[:setting_name]
      @entity_type = params[:entity_type]
      @type_class = eval @entity_type
    end
  
  end
end
