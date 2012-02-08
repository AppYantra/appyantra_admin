module AppyantraAdmin::ApplicationHelper
  def display_date(date)
    date.strftime("%d-%m-%Y %H:%M")
  end
  
  def setting_value(entity_name, default='Not Set')
    setting = AdminSetting.find_by_name(entity_name)
    if setting && setting.entity
      render partial: "/appyantra_admin/shared/types/#{setting.entity.class.name.downcase}", locals: { entity: setting.entity}
    else
      default  
    end  
  end
  
  def breadcrumb
    breadcrumb_html = ''
    if @breadcrumbs
      while !@breadcrumbs.empty? do
        curr_breadcrumb = @breadcrumbs.pop
        breadcrumb_html << "<a href='#{curr_breadcrumb[1]}'>#{curr_breadcrumb[0]}</a><div class='breadcrumb_divider'></div>"          
      end
      breadcrumb_html << "<a class='current'>#{@current_breadcrumb}</a>"
    end
    breadcrumb_html
  end

  def asset_display_field(asset_class_name)
    asset_class = eval asset_class_name
    asset_class.column_names[1].capitalize
  end

  def asset_display_name(asset)
    field_name = asset.class.column_names[1]
    asset[field_name]
  end
end
