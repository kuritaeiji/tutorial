class AddSessionIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :session_id, :string)
    add_index(:users, :session_id, unique: true)
  end
end