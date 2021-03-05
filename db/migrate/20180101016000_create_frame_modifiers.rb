class CreateFrameModifiers < ActiveRecord::Migration[6.0]

  def change

    create_table :frame_modifiers do |t|

      t.integer :race, null: false, default: 0

      t.integer :gender, null: false, default: 0

      t.integer :label, null: false, default: 0

      t.integer :score_limit, null: false, default: 0

      t.integer :modifier, null: false, default: 0

    end

  end

end
