class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8, maximum: 25 }
end