class CreateWritingImplementTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :writing_implement_templates do |t|
      t.references :item_template, null: false, index: true

      t.boolean :single_use, null: false, default: false
    end
  end
end
