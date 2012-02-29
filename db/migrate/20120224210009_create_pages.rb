class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.boolean :published
      t.integer :seo_settings_id
      t.string :layout
      t.string :category
      t.integer :fb_sharing_id
      t.integer :last_updated_by_id
      t.integer :created_by_id
      t.string :caching_strategy

      t.timestamps
    end
  end
end
