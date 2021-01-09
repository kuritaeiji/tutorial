class User < ApplicationRecord
  attr_accessor(:remember_token)

  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates(:name, presence: true, length: { maximum: 50} )
  validates(:email, presence: true, length: { maximum: 255},
    format: { with: VALID_EMAIL_REGEXP }, uniqueness: { case_sensitive: false } )
  validates(:password, presence: true, length: { minimum: 6 }, unless: -> { password.nil? } )

  before_save { self.email = email.downcase }

  has_secure_password

  class << self
    def digest(token)
      BCrypt::Password.create(token)
    end

    def create_token
      SecureRandom.urlsafe_base64(24)
    end
  end

  def remember
    self.remember_token = self.class.create_token
    update(remember_digest: self.class.digest(remember_token))
  end

  def authenticated?(remember_token)
    remember_digest == remember_token
  end

  def forget
    update(remember_digest: nil)
  end
end
