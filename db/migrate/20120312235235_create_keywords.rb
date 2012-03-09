class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :page_keywords do |t|
      t.integer :page_id
      t.string :keyword

      t.timestamps
    end
  end
end
