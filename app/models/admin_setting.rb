class AdminSetting < ActiveRecord::Base

  validates :name, uniqueness: { scope: :group }
  
  def entity
    type_class = eval self.entity_type
    type_class.find self.entity_id
  end

  def self.create_from_entity(name, entity, display_name=name.titleize, group='General')
    self.create(name: name, display_name: display_name,
                entity_type: entity.class.name,
                entity_id: entity.id,
                group: group)
  end

  # finds a setting by name and returns the value of the setting's entity. The entity should implement a entity_value method
  # if no setting exists for the name then returns nil
  def self.value_of(setting_name)
    setting = AdminSetting.find_by_name(setting_name)
    if setting && setting.entity
      setting.entity.entity_value
    end
  end

  # convenience method for initializing a settings group with empty values
  # fields should be a hash { <field_type(string))> : <field_names(string_array)> }
  # Only fields (model classes) having a name/value properties are supported (Text, ShortText etc.)
  # returns a hash of type { <field_name> : nil }
  def self.initialize_group(group, fields)
    group_settings = Hash.new
    fields.each do |field_type, field_names|
      field_names.each do |field_name|
        field_class = eval field_type
        field = field_class.create(name: field_name, value: nil)
        group_settings[field_name] = nil
        AdminSetting.create_from_entity(field_name, field, field_name.humanize, group)
      end
    end
    group_settings
  end

  def self.group_settings(group)
    group_settings = AdminSetting.where(group: group)
    settings_hash = Hash.new
    group_settings.each do |setting|
      settings_hash[setting.name] = setting.entity.entity_value
    end
    settings_hash
  end

  def self.update_group_settings(group, settings_hash)
    settings_hash.each do |setting_name, setting_value|
      setting = AdminSetting.find_by_group_and_name(group, setting_name)
      setting.entity.entity_value = setting_value
    end
  end
end