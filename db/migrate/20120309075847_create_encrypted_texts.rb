class CreateEncryptedTexts < ActiveRecord::Migration
  def change
    create_table :encrypted_texts do |t|
      t.string :name
      t.binary :value

      t.timestamps
    end
  end
end
