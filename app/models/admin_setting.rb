class AdminSetting < ActiveRecord::Base

  validates :name, uniqueness: { scope: :group }

  scope :managed_groups, where("admin_settings.group != 'Mail'").select("distinct admin_settings.group")

  after_create :clear_pages
  after_update :clear_pages
  after_destroy :clear_pages
  
  def entity
    type_class = eval self.entity_type
    type_class.find self.entity_id
  end

  def self.create_from_entity(name, entity, group='General', display_name=name.titleize)
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
        AdminSetting.create_from_entity(field_name, field, group, field_name.humanize)
      end
    end
    group_settings
  end

  def self.group_settings(group)
    group_settings = AdminSetting.where(group: group)
    settings_hash = Hash.new
    group_settings.each do |setting|
      entity_value = setting.entity.entity_value
      settings_hash[setting.name.to_sym] = entity_value
    end
    settings_hash
  end

  def self.update_group_settings(group, settings_hash)
    settings_hash.each do |setting_name, setting_value|
      setting = AdminSetting.find_by_group_and_name(group, setting_name)
      setting.entity.entity_value = setting_value
    end
  end

  private

  def clear_pages
    if self.group == 'Google Analytics'
      # clears all the cached pages
      FileUtils.rm_rf Rails.root.join("public/pages")
    end
  end
end