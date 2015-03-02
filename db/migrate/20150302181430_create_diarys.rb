class CreateDiarys < ActiveRecord::Migration
  def change
    create_table :diarys do |t|
      t.string :content
      t.integer :post_id
      t.integer :user_id
      t.timestamps
    end
  end
end
