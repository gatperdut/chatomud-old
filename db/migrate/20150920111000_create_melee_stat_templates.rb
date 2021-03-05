class CreateMeleeStatTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :melee_stat_templates do |t|
      t.references :weapon_stat_template, index: true

      t.string :sheathed_desc
    end
  end
end
