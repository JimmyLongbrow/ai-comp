class Sequence < ApplicationRecord
  belongs_to :user
  has_many :recordings
end
