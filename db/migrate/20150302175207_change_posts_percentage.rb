class ChangePostsPercentage < ActiveRecord::Migration
  def change
    change_column :posts, :percentage, :integer, default: 0 rescue nil  
  end
end
