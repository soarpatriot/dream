class AuthToken < ActiveRecord::Base
  # value user_id
  belongs_to :user

  before_create :generate_token

  private

  def generate_token
    begin
      self.value = SecureRandom.hex
    end while self.class.exists?(value: self.value)
  end
end
