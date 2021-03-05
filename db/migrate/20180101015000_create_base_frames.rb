class CreateBaseFrames < ActiveRecord::Migration[6.0]

  def change

    create_table :base_frames do |t|

      t.integer :race, null: false, default: 0

      t.integer :score_limit, null: false, default: 0

      t.integer :height, null: false, default: 0 # In centimeters.

      t.integer :weight, null: false, default: 0 # In kilograms.

      t.integer :label, null: false, default: 0

      t.integer :column, null: false, default: 0

    end

  end

end
