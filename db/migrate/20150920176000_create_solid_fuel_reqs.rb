class CreateSolidFuelReqs < ActiveRecord::Migration[6.0]
  def change
    create_table :solid_fuel_reqs do |t|
      t.references :light_source, index: true
    end
  end
end
