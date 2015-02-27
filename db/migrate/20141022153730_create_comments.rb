class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :image
      t.string :sound
      t.string :content
      t.timestamps
    end
  end
end
