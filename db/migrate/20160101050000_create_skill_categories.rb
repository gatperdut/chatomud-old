class CreateSkillCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :skill_categories do |t|
      t.integer :name, null: false

      t.string :dependencies, null: false, array: true, default: [].to_yaml
    end
  end
end
