class PagesController < ApplicationController
  def home

    #initialisation de toutes les transactions
    @transactions = Transaction.all

    #calcul du montant total
    @total = 0
    @transactions.each do |trans|
      @total += (trans.unit_price * trans.quantity)
    end

  end
end
