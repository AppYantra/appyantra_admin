class AdminSetting < ActiveRecord::Base
  
  def entity
    type_class = eval self.entity_type
    type_class.find self.entity_id
  end

  def self.create_from_entity(name, entity, display_name=name.titleize)
    self.create(name: name, display_name: display_name,
                entity_type: entity.class.name,
                entity_id: entity.id)
  end
end