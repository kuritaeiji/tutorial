class User < ApplicationRecord
  has_many(:microposts, dependent: :destroy)

  has_many(:active_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy)
  has_many(:followings, through: :active_relationships, source: :followed)
  has_many(:passive_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy)
  has_many(:followers, through: :passive_relationships, source: :follower)

  attr_accessor(:remember_token, :activation_token, :reset_token)

  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates(:name, presence: true, length: { maximum: 50} )
  validates(:email, presence: true, length: { maximum: 255},
    format: { with: VALID_EMAIL_REGEXP }, uniqueness: { case_sensitive: false } )
  validates(:password, presence: true, length: { minimum: 6 }, unless: -> { password.nil? } )

  before_save { self.email = email.downcase }
  before_create(:create_activation_digest)
  after_create { UserMailer.account_activation(self).deliver_now }

  default_scope(-> { order(id: :asc) })


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

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest".to_sym)
    return false if digest.nil?
    BCrypt::Password.new(digest) == token
  end

  def forget
    update(remember_digest: nil)
  end

  def create_reset_token_and_digest
    self.reset_token = self.class.create_token
    reset_digest = self.class.digest(reset_token)
    update(reset_digest: reset_digest, reset_sent_at: Time.zone.now)
  end

  def send_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at > 1.day.ago
  end

  def feed
    microposts
  end

  def follow(other_user)
    relationship = active_relationships.new(followed_id: other_user.id)
    relationship.save
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  private
    def create_activation_digest
      self.activation_token = self.class.create_token
      self.activation_digest = self.class.digest(activation_token)
    end
end
