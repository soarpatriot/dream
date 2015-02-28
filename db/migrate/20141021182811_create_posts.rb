class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :dream
      t.string :reality
      t.string :percentage
      t.timestamps
    end
  end
end
