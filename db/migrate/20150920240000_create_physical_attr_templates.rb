class CreatePhysicalAttrTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :physical_attr_templates do |t|

      t.references :parent, null: false, index: true, polymorphic: true

      t.string :genders, null: false, array: true, default: [].to_yaml

      t.integer :race, null: false, default: 0

      t.integer :height_category, null: false, default: 0

      t.integer :weight_category, null: false, default: 0

    end
  end

end
