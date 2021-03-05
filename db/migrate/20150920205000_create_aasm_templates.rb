class CreateAasmTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :aasm_templates do |t|
      t.integer :code, null: false, default: 0

      t.references :character_template, null: false, index: true
    end
  end

end
