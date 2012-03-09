class AddGroupToAdminSettings < ActiveRecord::Migration
  def change
    add_column :admin_settings, :group, :string
  end
end
