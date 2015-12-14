class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :installation, index: true, foreign_key: true
      t.integer :hipchat_id, index: true
      t.string :mention_name
      t.string :name

      t.timestamps null: false
    end
  end
end
