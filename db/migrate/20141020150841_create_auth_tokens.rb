class CreateAuthTokens < ActiveRecord::Migration
  create_table :auth_tokens do |t|
    t.string :value
    t.integer :user_id
    t.datetime :expire_at

    t.timestamps
  end
end
