class User < ApplicationRecord
  has_secure_password

  has_many :messages, foreign_key: :created_by

  validates_presence_of :name, :email, :password_digest
  validates :email, uniqueness: true
end
