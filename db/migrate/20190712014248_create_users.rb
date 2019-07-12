class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    enable_extension 'citext' # only the first migration you add a citext column
    create_table :users do |t|
      t.citext :email
      t.citext :name
      t.boolean :global_admin, default: false
      t.citext :timezone
      t.boolean :receive_marketing, default: false
      t.citext :external_id
      t.citext :skills, array: true, default: []

      t.timestamps
    end
  end

  def down
    drop_table :users
    disable_extension 'citext' # disable this here on a `down` migration because the first time we enable it is in this migration's `up`
  end
end
