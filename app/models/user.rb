class User < ApplicationRecord
  before_create :confirmation_token
  has_many :sequences
  has_many :recordings
  has_and_belongs_to_many :liked_recordings, class_name: 'Recording'
  has_secure_password
  validates :name, length:{ minimum: 2, maximum: 20}
  validates_email_realness_of :email
  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
    # validates :password, length: { minimum:4 }
    has_many :following_relationships, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
    has_many :followed_relationships, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
    has_many :following, through: 'following_relationships', source: 'followed'
    has_many :followers, through: 'followed_relationships', source: 'follower'
end
