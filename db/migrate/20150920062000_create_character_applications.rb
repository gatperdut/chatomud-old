class CreateCharacterApplications < ActiveRecord::Migration[6.0]

  def change

    create_table :character_applications do |t|

      t.references :player, index: true

      t.string :name, null: false

      t.string :short_desc, null: false

      t.string :long_desc,  null: false

      t.text   :full_desc,  null: false

      t.string :kwords, array: true

      t.string :skill_picks, array: true

    end

  end

end
