class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.integer :name, null: false

      t.integer :skill_category, null: false

      t.string :dependencies, null: false, array: true, default: [].to_yaml
    end
  end
end
