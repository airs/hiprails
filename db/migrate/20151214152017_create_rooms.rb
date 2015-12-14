class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :installation, index: true, foreign_key: true
      t.integer :hipchat_id
      t.boolean :archived
      t.string :name
      t.string :privacy
      t.string :version

      t.timestamps null: false
    end
  end
end
