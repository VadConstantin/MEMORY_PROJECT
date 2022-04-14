class PagesController < ApplicationController
  def home

    #initialisation de toutes les transactions
    @transactions = Transaction.all

    #filtres avec PG search
    params[:country].present? ? @transactions = @transactions.search_by_country(params[:country]).reorder('').distinct : @transactions = Transaction.all
    @transactions = Transaction.all if params[:country] == "All"

    #calcul du montant total
    @total = 0
    @transactions.each do |trans|
      @total += (trans.unit_price * trans.quantity)
    end

    #calcul de la moyenne par order
    unique_orders = count_unique_orders(@transactions)
    @average_revenue_per_order = @total.fdiv(unique_orders)

    #calcul du nombre de clients uniques
    @unique_customers = count_unique_customers(@transactions)

    #graph
    @graph_transactions = @transactions.group_by_month(:date, format: "%B %Y").sum(:quantity)

  end


  private


  def count_unique_orders(transactions)
    array_of_orders = []
    transactions.each do |t|
      array_of_orders << t.order_id
      end

    # methode pour compter le nombre d'élements uniques dans un array. On regroupe, on map, on convertit en hash avec clé: element, valeur : récurrence, puis compter le nombre de clés avec .length
    return array_of_orders.group_by{|e| e}.map{|k, v| [k, v.length]}.to_h.length
  end

  def count_unique_customers(transactions)
    array_of_customers = []
    transactions.each do |t|
      array_of_customers << t.customer_id
    end
    return array_of_customers.group_by{|e| e}.map{|k, v| [k, v.length]}.to_h.length
  end


end
