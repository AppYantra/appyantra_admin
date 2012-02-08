module AppyantraAdmin
  class ApplicationController < ActionController::Base
    protect_from_forgery
  
    before_filter :set_objects
    
    def set_objects
      @assets = AppyantraAdmin.assets
    end
    
    def get_object_name(asset_class)
      asset_class.table_name.singularize
    end
    
    def add_breadcrumb(breadcrumb)
    	@breadcrumbs = Queue.new unless @breadcrumbs
    	@breadcrumbs << breadcrumb
    end
    
    def current_breadcrumb(breadcrumb)
    	@current_breadcrumb = breadcrumb
    end

    def asset_display_name(asset)
      field_name = asset.class.column_names[1]
      asset[field_name]
    end

  end
end
