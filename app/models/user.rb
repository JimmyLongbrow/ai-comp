class User < ApplicationRecord
  has_many :sequences
  has_many :recordings
  has_secure_password
  validates :name, length:{ minimum: 2, maximum: 20}
  validates_email_realness_of :email
  validates :password, length: { minimum:4 }
end
