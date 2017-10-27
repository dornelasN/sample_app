class User < ApplicationRecord
  before_save { email.downcase! }
  
  validates(:name,  presence: true, length: { maximum: 50 })

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  validates(:email, presence: true, length: { maximum: 255 }, 
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false })
                    #Active Record uniqueness validation does not guarantee uniequeness at
                    #database level

  has_secure_password #built in method to add a secure password

  validates(:password, presence: true, length: { minimum: 6 })
end
