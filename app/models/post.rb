class Post < ActiveRecord::Base

  default_scope {order("id desc")}
  belongs_to :user
  has_many :comments
  mount_uploader :image, PostImageUploader
  mount_uploader :sound, PostSoundUploader

end
