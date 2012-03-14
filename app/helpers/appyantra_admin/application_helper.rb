module AppyantraAdmin::ApplicationHelper
  def display_date(date)
    date.strftime("%m-%d-%Y %H:%M")
  end
  
  def setting_value(entity_name, default='Not Set')
    setting = AdminSetting.find_by_name(entity_name)
    if setting && setting.entity
      render partial: "/appyantra_admin/shared/types/#{setting.entity.class.name.underscore}", locals: { entity: setting.entity}
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

  # displays the name of the first field of a model
  def asset_display_field(asset_class_name)
    asset_class = eval asset_class_name
    asset_class.column_names[1].capitalize
  end

  # displays the value of the first field of a model object (asset)
  def asset_display_name(asset)
    field_name = asset.class.column_names[1]
    asset[field_name]
  end

  def page_title
    if @page
      @page.title
    elsif @page_title
      @page_title
    end
  end

  def path_for slug
    if Page.where(slug: slug).exists?
      main_app.display_page_path(slug)
    else
      '#'
    end
  end

  def include_rich_text_editor
    if AdminSetting.value_of('rich_text_editor') == 'ckeditor'
      javascript_include_tag "ckeditor/ckeditor.js"
    end
  end

  def google_analytics_script
    analytics_settings = AdminSetting.group_settings('Google Analytics')
    if analytics_settings.has_key?(:tracking_code) && analytics_settings.has_key?(:domain)
      tracking_code = analytics_settings[:tracking_code]
      domain = analytics_settings[:domain]
      render partial: '/pages/google_analytics', locals: { analytics_tracking_code: tracking_code, analytics_domain: domain }
    end
  end

  def fetch_activity_feeds
    ActivityFeed.latest
  end
end
