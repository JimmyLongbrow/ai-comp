class Recording < ApplicationRecord
  belongs_to :sequence, optional: true
  belongs_to :user, optional: true
  has_and_belongs_to_many :liked_by_users, class_name:'User'
end
