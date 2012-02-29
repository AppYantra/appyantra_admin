class AdminSetting < ActiveRecord::Base

  validates_uniqueness_of :name
  
  def entity
    type_class = eval self.entity_type
    type_class.find self.entity_id
  end

  def self.create_from_entity(name, entity, display_name=name.titleize)
    self.create(name: name, display_name: display_name,
                entity_type: entity.class.name,
                entity_id: entity.id)
  end

  # finds a setting by name and returns the value of the setting's entity. The entity should implement a entity_value method
  # if no setting exists for the name then returns nil
  def self.value_of(setting_name)
    setting = AdminSetting.find_by_name(setting_name)
    if setting && setting.entity
      setting.entity.entity_value
    end
  end
end