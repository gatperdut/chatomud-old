class CreateBookTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :book_templates do |t|
      t.references :item_template,  null: false, index: true

      t.integer    :page_count, null: false, default: 10
    end
  end
end
