class AddIndexesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
    add_index :users, :external_id, unique: true
    # add_index :users, :skills, using: :gin
  end
end
