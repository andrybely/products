class AddPasswordHashToGuests < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :password_hash, :string
    add_column :guests, :password_salt, :string
  end
end
