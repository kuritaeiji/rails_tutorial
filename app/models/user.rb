class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    BCrypt::Password.create(string)
  end

  def remember
    self.remember_token = User.new_token
    digest = User.digest(remember_token)
    update_attribute(:remember_digest, digest)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    remember_token == remember_digest
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end