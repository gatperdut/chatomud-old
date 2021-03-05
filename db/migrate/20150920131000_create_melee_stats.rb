class CreateMeleeStats < ActiveRecord::Migration[6.0]
  def change
    create_table :melee_stats do |t|
      t.references :weapon_stat, index: true

      t.string :sheathed_desc
    end
  end
end
