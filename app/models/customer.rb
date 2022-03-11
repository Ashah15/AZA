class Customer < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase, self.username = username.downcase }
  before_create :remember_token
  validates :username, presence: true, length: { maximum: 20 }, uniqueness: true

  # Returns the hash digest of the given string.
  def self.digest(_string)
    # cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    # BCrypt::Engine.cost
    # BCrypt::Password.create(string, cost: cost)

    if ActiveModel::SecurePassword.min_cost
      BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
end
