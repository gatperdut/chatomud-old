class CreateLightSourceTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :light_source_templates do |t|
      t.references :item_template, null: false, index: true

      t.boolean :lit, null: false, default: false

      t.boolean :must_be_held_to_light, null: false, default: false

      t.integer :efficiency, null: false, default: 720 # Light time in seconds per unit of fuel.

      t.integer :burndown,   null: false, default: 720 # Burndown of the current fuel point.
    end
  end
end
