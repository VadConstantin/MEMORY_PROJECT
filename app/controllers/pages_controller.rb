# rubocop:disable Metrics/MethodLength

class PagesController < ApplicationController

  def home
    if params[:country].present?
      transactions = Transaction.filtered(params[:country])
    else
      transactions = Transaction.all
    end

    @countries = Transaction.countries.map(&:country)

    @total                     = transactions.total
    @unique_orders             = transactions.unique_orders
    @average_revenue_per_order = transactions.average_revenue_per_order
    @unique_customers          = transactions.unique_customers
    @graph_transactions        = transactions.graph_transactions
  end

end
# rubocop:enable Metrics/MethodLength
