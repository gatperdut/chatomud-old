class CreateAttacks < ActiveRecord::Migration[6.0]
  def change
    create_table :attacks do |t|
      t.boolean :connects, default: true, null: false

      t.integer :score_limit, null: false

      t.integer :base, null: false

      t.integer :against, null: false

      t.integer :hits, null: false
      t.integer :critical_severity, null: false
      t.integer :critical_type, null: false
    end
  end
end
