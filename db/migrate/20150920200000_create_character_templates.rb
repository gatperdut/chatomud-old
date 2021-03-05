class CreateCharacterTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :character_templates do |t|

      t.string :short_desc, null: false
      t.string :long_desc,  null: false
      t.text   :full_desc,  null: false

      t.string :code, null: false

      t.string :names, null: false, array: true
      t.string :noun, null: false
      t.string :short_descs, null: false, array: true
      t.string :long_desc_endings, null: false, array: true
    end
  end
end
