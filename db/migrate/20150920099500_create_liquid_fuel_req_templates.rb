class CreateLiquidFuelReqTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :liquid_fuel_req_templates do |t|
      t.references :light_source_template, index: true

      t.string :options, null: false, array: true, default: [].to_yaml
    end
  end
end
