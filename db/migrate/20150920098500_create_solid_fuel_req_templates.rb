class CreateSolidFuelReqTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :solid_fuel_req_templates do |t|
      t.references :light_source_template, index: true
    end
  end
end
