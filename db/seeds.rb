# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

CSV.foreach('lib/memory-tech-challenge-data.csv', headers: true) do |row|

  Transaction.create({
    date: row[0],
    order_id: row[1],
    customer_id: row[2],
    country: row[3],
    product_code: row[4],
    product_description: row[5],
    quantity: row[6],
    unit_price: row[7]
  })
end

puts "seed is completed ! :) "
