class CreateChoiceTemplates < ActiveRecord::Migration[6.0]

  def change
    create_table :choice_templates do |t|
      t.references :character_template, null: false, index: true

      t.integer :stance, null: false, default: 3

      t.integer :pace, null: false, default: 2

      t.boolean :editor_echoes, null: false, default: true

      t.integer :language, null: false, default: 0

      t.integer :script, null: false, default: 0
    end
  end

end
