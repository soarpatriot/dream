class User < ActiveRecord::Base

  acts_as_voter

  has_secure_password

  has_one :auth_token, dependent: :destroy
  has_many :posts
  has_many :diaries, through: :post
  validates :name, :password_digest, presence:true
  validates :name,  uniqueness: true

  mount_uploader :avatar, UserAvatarUploader
end
