class Diary < ActiveRecord::Base
  
  belongs_to :post
  belongs_to :user


end
