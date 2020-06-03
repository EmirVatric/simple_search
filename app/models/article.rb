class Article < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: %i(title content),:using => {
    :tsearch => {:prefix => true}
  }
end
