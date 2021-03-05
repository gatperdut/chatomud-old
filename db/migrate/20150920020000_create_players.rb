class CreatePlayers < ActiveRecord::Migration[6.0]

  def change
    create_table :players do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :authentication_token, null: false
    end
  end

end
