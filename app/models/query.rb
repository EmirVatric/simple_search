# frozen_string_literal: true

class Query < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search, against: :query,
                           using: :trigram
  scope :user, lambda { |user_id|
    where(user_id: user_id)
  }

  validates :user_id, presence: true
  validates :query, presence: true
  validates :act_identifier, presence: true
end
