class CreateDailys < ActiveRecord::Migration
  def change
    create_table :dailys do |t|
      t.string :content
      t.integer :post_id
      t.integer :user_id
      t.timestamps
    end
  end
end
