require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AppyantraAdmin::ApplicationHelper. For example:
#
# describe AppyantraAdmin::ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AppyantraAdmin::ApplicationHelper do

  let(:field_name) { 'Name'}
  let(:asset_class_name) { 'Product'}
  let(:product_asset) { Factory.create(:product) }

  it "setting_value should render setting value partial"

  it "breadcrumb should render the breadcrums html"

  it "asset_display_field should display the name of the first field of a model" do
    helper.asset_display_field(asset_class_name).should eq(field_name)
  end

  it "asset_display_name should display the value of the first field of a model object (asset)" do
    helper.asset_display_name(product_asset).should eq(product_asset.name)
  end

end
