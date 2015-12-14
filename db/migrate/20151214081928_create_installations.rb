class CreateInstallations < ActiveRecord::Migration
  def change
    create_table :installations do |t|
      t.string :oauth_id, index: true
      t.string :capabilities_url
      t.integer :room_id
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
