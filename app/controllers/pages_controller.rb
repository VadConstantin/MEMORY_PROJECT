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
    @total = 0
    transactions.each do |trans|
      @total += (trans.unit_price * trans.quantity)
    end

    # calcul de la moyenne par order
    unique_orders = count_unique_orders(transactions)
    @average_revenue_per_order = @total.fdiv(unique_orders)

    # calcul du nombre de clients uniques
    @unique_customers = count_unique_customers(transactions)

    # graph
    @graph_transactions = transactions.group_by_month(:date, format: "%B %Y").sum('quantity * unit_price')
  end

  private

  def count_unique_orders(transactions)
    array_of_orders = []
    transactions.each do |t|
      array_of_orders << t.order_id
      end
    return array_of_orders.group_by{|e| e}.length
  end

  def count_unique_customers(transactions)
    array_of_customers = []
    transactions.each do |t|
      array_of_customers << t.customer_id
    end
    return array_of_customers.group_by{|e| e}.length
  end

  def count_unique_countries(transactions)
    array_of_countries = []
    transactions.each do |t|
      array_of_countries << t.country
    end
    return array_of_countries.group_by {|country| country}.map {|k, v| [k]}.flatten
  end
end
# rubocop:enable Metrics/MethodLength
