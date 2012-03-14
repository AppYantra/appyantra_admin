class ShortText < ActiveRecord::Base

  after_update :update_setting

  def entity_value
    self.value
  end

  def entity_value=(value)
    self.value = value
    self.save
  end

  def update_setting
    # TODO try to move this code to the setting class and improve the design
    parent_setting = AdminSetting.find_by_entity_id_and_entity_type(self.id,'ShortText')
    if parent_setting
      parent_setting.name = self.name
      parent_setting.display_name = self.name.humanize
      parent_setting.save
    end
  end
end