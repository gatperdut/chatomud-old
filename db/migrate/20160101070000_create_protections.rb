class CreateProtections < ActiveRecord::Migration[6.0]
  def change
    create_table :protections do |t|
      t.integer :level, null: false

      t.integer :min_penalty, null: false

      t.integer :max_penalty, null: false
    end
  end
end
