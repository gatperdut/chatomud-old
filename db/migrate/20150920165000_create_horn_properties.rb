class CreateHornProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :horn_properties do |t|
      t.references :item, index: true

      t.string :echo, null: false
      t.string :action_echo_self, null: false
      t.string :action_echo_others, null: false

      t.integer :reach, null: false, default: 0
    end
  end
end
