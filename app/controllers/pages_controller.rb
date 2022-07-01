# rubocop:disable Metrics/MethodLength
class PagesController < ApplicationController

  def home

    # filtres avec PG search
    params[:country].present? ? transactions = Transaction.search_by_country(params[:country]).reorder('') : transactions = Transaction.all
    transactions = Transaction.all if params[:country] == "All"

    # trouver tous les pays
    all_transactions = Transaction.all
    @countries = count_unique_countries(all_transactions)

    # calcul du montant total
    @total = Transaction.total

    # calcul de la moyenne par order
    @unique_orders = Transaction.unique_orders
    # unique_orders = count_unique_orders(transactions)
    # @average_revenue_per_order = @total.fdiv(unique_orders) if unique_orders != 0
    @average_revenue_per_order = Transaction.average_revenue_per_order

    # calcul du nombre de clients uniques
    @unique_customers = count_unique_customers(transactions)

    # graph
    @graph_transactions = transactions.group_by_month(:date, format: "%B %Y").sum('quantity * unit_price')
  end

  private

  def count_unique_orders(transactions)
    array_of_orders = transactions.map {|transaction| transaction.order_id}
    return array_of_orders.uniq.length
  end

  def count_unique_customers(transactions)
    array_of_customers = transactions.map {|transaction| transaction.customer_id}
    return array_of_customers.uniq.length
  end

  def count_unique_countries(transactions)
    array_of_countries = transactions.map {|transaction| transaction.country}
    return array_of_countries.group_by {|country| country}.map {|k, v| [k]}.flatten
  end
end
# rubocop:enable Metrics/MethodLength
