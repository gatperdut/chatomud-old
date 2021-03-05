class CreateItemTemplatesSolidFuelReqTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :item_templates_solid_fuel_req_templates, id: false do |t|
      t.references :item_template,           null: false, index: { name: "index_itsfrt_on_it_id" }
      t.references :solid_fuel_req_template, null: false, index: { name: "index_itsfrt_on_sfrt_id" }
    end
  end
end
