class Transaction < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_country,
    against: [ :country],
    using: {
      tsearch: { prefix: true }
    }
end
