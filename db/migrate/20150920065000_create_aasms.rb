class CreateAasms < ActiveRecord::Migration[6.0]
  def change
    create_table :aasms do |t|
      t.integer :code, null: false, default: 0

      t.boolean :active, null: false, default: true

      t.references :character, index: true
    end
  end

end
