class PagesController < ApplicationController
  def home

    #initialisation de toutes les transactions
    @transactions = Transaction.all

    #calcul du montant total
    @total = 0
    @transactions.each do |trans|
      @total += (trans.unit_price * trans.quantity)
    end

    #calcul de la moyenne par order
    unique_orders = count_unique_orders(@transactions)
    @average_revenue_per_order = @total.fdiv(unique_orders)
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


end
