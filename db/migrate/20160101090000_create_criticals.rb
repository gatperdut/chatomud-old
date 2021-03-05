class CreateCriticals < ActiveRecord::Migration[6.0]
  def change
    create_table :criticals do |t|
      t.integer :damage_type, null: false

      t.integer :severity, null: false

      t.integer :score_limit, null: false

      t.integer :extra_hits, null: false
      t.integer :blood_loss, null: false

      t.integer :attack_stun_type, null: false
      t.integer :attack_stun_rounds, null: false
      t.integer :attack_stun_penalty, null: false

      t.integer :parry_stun_type, null: false
      t.integer :parry_stun_rounds, null: false
      t.integer :parry_stun_penalty, null: false

      t.string :message, null: false
    end
    add_index :criticals, [:damage_type, :severity, :score_limit]
  end
end
