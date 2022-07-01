class Transaction < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_country,
                  against: [:country],
                  using: { tsearch: { prefix: true } }
  scope :filtered, ->(filter) { where(country: filter) }

  class << self
    def total
      self.sum("transactions.quantity * transactions.unit_price")
    end

    def unique_orders
      self.select(:order_id).distinct.count
    end

    def average_revenue_per_order
      self.sum("(transactions.quantity * transactions.unit_price)").fdiv(self.select(:order_id).distinct.count)
    end

    def unique_customers
      self.select(:customer_id).distinct.count
    end

    def countries
      self.select(:country).distinct
    end
  end
end
