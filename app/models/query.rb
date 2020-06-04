class Query < ApplicationRecord
  validates :user_id, presence: true
  validates :query, presence: true
  validates :act_identifier, presence: true
end
