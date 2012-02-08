class AdminSetting < ActiveRecord::Base
  
  def entity
    type_class = eval self.entity_type
    type_class.find self.entity_id
  end
end