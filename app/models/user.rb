class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  
  validates(:name,  presence: true, length: { maximum: 50 })

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates(:email, presence: true, length: { maximum: 255 }, 
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false })
                    #Active Record uniqueness validation does not guarantee uniequeness at
                    #database level

  has_secure_password #built in method to add a secure password

  validates(:password, presence: true, length: { minimum: 6 }, allow_nil: true)

  class << self
    # returns the hash digest of the given string
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

      BCrypt::Password.create(string, cost: cost)
    end

    # return a random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # generalized method to use for remember_digest and activation_digest
  # returns true if the given token matches the digest, and false in case the digest is nil
  def authenticated?(attribute, token)
    # send the remember_digest or the activation_digest to the variable digest
    digest = send("#{attribute}_digest")
    # if digest is nul, return false
    return false if digest.nil?
    # else, return true and encrypt the new digest token with BCrypt
    BCrypt::Password.new(digest).is_password?(token)
  end

  # forgets a user. Undoes remember method
  def forget
    update_attribute(:remember_digest, nil)
  end
end

private

  def downcase_email
    email.downcase! # == (self.email = email.downcase)
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
