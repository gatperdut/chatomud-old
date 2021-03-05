class CreateAmountDataTemplates < ActiveRecord::Migration[6.0]

  def change

    create_table :amount_data_templates do |t|

      t.references :amount_template, null: false, index: true

      t.integer :fluid, null: true

      t.integer :calories, null: true # Per bite/sip.

      t.integer :hydration, null: true # In milliliters, per bite/sip.

    end

  end

end
