class CreateAdminSettings < ActiveRecord::Migration
  def change
    create_table :admin_settings do |t|
      t.string :name
      t.string :display_name
      t.string :entity_type
      t.integer :entity_id

      t.timestamps
    end
  end
end
