class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.datetime   :created_at, null: false

      t.references :parent,     null: false, index: true, polymorphic: true

      t.integer    :page,       null: true,  default: nil

      t.string     :title, null: true, default: nil

      t.text       :content, null: true, default: nil
    end
  end

end
