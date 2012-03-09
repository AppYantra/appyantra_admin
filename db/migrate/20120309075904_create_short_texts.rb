class CreateShortTexts < ActiveRecord::Migration
  def change
    create_table :short_texts do |t|
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
