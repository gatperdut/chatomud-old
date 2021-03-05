class CreateItemTemplatesSolidFuelReqs < ActiveRecord::Migration[6.0]
  def change
    create_table :item_templates_solid_fuel_reqs, id: false do |t|
      t.references :item_template,  null: false, index: true
      t.references :solid_fuel_req, null: false, index: true
    end
  end
end
