class CreateSettings < ActiveRecord::Migration[6.0]

  def change
    create_table :settings do |t|
      t.boolean :ansi_coloring, default: false, null: false

      t.references :player, null: false, index: true
    end
  end

end
