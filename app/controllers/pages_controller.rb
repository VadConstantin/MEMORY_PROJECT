# rubocop:disable Metrics/MethodLength
# rubocop:disable Style/MultilineTernaryOperator
class PagesController < ApplicationController

  def home

    params[:country].present? ?
      transactions = Transaction.filtered(params[:country])
    : transactions = Transaction.all

    @countries = Transaction.countries.map do |country|
      country.country
    end

    @total = transactions.total
    @unique_orders = transactions.unique_orders
    @average_revenue_per_order = transactions.average_revenue_per_order
    @unique_customers = transactions.unique_customers

    # graph
    @graph_transactions = transactions.group_by_month(:date, format: "%B %Y").sum('quantity * unit_price')
  end

end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Style/MultilineTernaryOperator
