class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|
      t.string :item_type
      t.integer :item_id
      t.string :item
      t.string :actor
      t.string :actor_type
      t.integer :actor_id
      t.string :activity

      t.timestamps
    end
  end
end
