class Transaction < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_country,
                  against: [:country],
                  using: { tsearch: { prefix: true } }

  scope :filtered, ->(filter) { where(country: filter) }

  class << self
    def total
      sum("transactions.quantity * transactions.unit_price")
    end

    def unique_orders
      select(:order_id).distinct.count
    end

    def average_revenue_per_order
      sum("(transactions.quantity * transactions.unit_price)").fdiv(select(:order_id).distinct.count)
    end

    def unique_customers
      select(:customer_id).distinct.count
    end

    def countries
      select(:country).distinct
    end

    def graph_transactions
      group_by_month(:date, format: "%B %Y").sum('quantity * unit_price')
    end
  end
end
