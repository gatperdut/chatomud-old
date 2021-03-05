class CreateLiquidFuelReqs < ActiveRecord::Migration[6.0]
  def change
    create_table :liquid_fuel_reqs do |t|
      t.references :light_source, index: true

      t.string :options, null: false, array: true, default: [].to_yaml
    end
  end
end
