class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_type
      t.text :description

      t.timestamps
    end
  end
end
