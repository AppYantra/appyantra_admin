module AppyantraAdmin::AdminSettingsHelper
  def fetch_group_settings(group)
    AdminSetting.where(group: group)
  end

  def settings_groups
    AdminSetting.managed_groups
  end
end
