class RemoveRoles < ActiveRecord::Migration[5.0]
  def change
    remove_column :roles, :name, :string
    remove_column :assignments, :user_id, :integer
    remove_column :assignments, :role_id, :integer
  end
end
