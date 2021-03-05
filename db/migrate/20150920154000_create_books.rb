class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.references :item,          null: false, index: true

      t.integer    :page_count,    null: false, default: 10

      t.integer    :current_page,  null: true,  default: nil
    end
  end
end
