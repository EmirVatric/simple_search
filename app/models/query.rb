class Query < ApplicationRecord
  validates :user_id, presence: true
  validates :query, presence: true
end
