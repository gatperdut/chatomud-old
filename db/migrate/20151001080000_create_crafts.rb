class CreateCrafts < ActiveRecord::Migration[6.0]

  def change
    create_table :crafts do |t|
      t.string :name,     null: false, index: true
      t.string :category, null: false, index: true
    end
  end

end
