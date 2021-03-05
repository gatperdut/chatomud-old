class CreateHornPropertyTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :horn_property_templates do |t|
      t.references :item_template, null: false, index: true

      t.string :echo, null: false
      t.string :action_echo_self, null: false
      t.string :action_echo_others, null: false

      t.integer :reach, null: false, default: 0
    end
  end
end
