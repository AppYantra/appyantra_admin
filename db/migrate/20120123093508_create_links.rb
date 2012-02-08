class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :text
      t.string :href
      t.string :rel
      t.string :target
      t.string :type
      t.string :title

      t.timestamps
    end
  end
end
