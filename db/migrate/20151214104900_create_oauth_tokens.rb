class CreateOauthTokens < ActiveRecord::Migration
  def change
    create_table :oauth_tokens do |t|
      t.references :installation, index: true, foreign_key: true
      t.string :access_token
      t.integer :expires_in
      t.integer :group_id
      t.string :group_name
      t.string :scope
      t.string :token_type

      t.timestamps null: false
    end
  end
end
