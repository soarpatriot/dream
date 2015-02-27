class AddUserIdAndPostIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :post_id, :integer
  end
end
