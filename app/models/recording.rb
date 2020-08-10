class Recording < ApplicationRecord
  belongs_to :sequence
  belongs_to :user
end
