class CreateSkillSetTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :skill_set_templates do |t|
      t.references :character_template, null: false, index: true

      t.string :chosen, null: false, array: true, default: [].to_yaml
    end
  end
end
