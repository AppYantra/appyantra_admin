require 'spec_helper'

describe AdminSetting do

  let(:link) { Factory.create(:link) }
  let(:text_entity) { Factory.create(:text) }
  let(:link_admin_setting) { Factory.create(:admin_setting, entity_type: 'Link', entity_id: link.id) }

  it "should return the associated setting entity" do
    link_admin_setting.entity.should eq link
  end

  it "can be created using an existing entity" do
    AdminSetting.create_from_entity(text_entity.name, text_entity)
    admin_setting = AdminSetting.find_by_name(text_entity.name)
    admin_setting.should be
    admin_setting.name.should eq(text_entity.name)
    admin_setting.display_name.should eq(text_entity.name.titleize)
    admin_setting.entity_id.should == text_entity.id
    admin_setting.entity_type.should eq(text_entity.class.name)
  end
end
