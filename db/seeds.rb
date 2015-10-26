# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
(1..100).each do |i|
  Book.create(title: "Book"+i.to_s, price: i.to_i, in_stock: 12, "author_id"=> 1, "category_id" => 1)
end